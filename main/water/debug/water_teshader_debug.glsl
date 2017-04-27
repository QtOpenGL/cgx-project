#version 410 core

layout(quads, equal_spacing, ccw) in;

uniform mat4 MVP;
uniform mat4 MV;
uniform mat4 NORMALM;
uniform sampler2D normalMap;
uniform float time;

in vec3 vpoint_TE[];
in vec2 uv_TE[];

out vec2 uv_G;
out vec2 reflectOffset_G;
out vec3 waveNormal_G;

const float DEGTORAD = 3.14159265359f / 180.0f;

float freqs[5] = float[5](100.0f, 125.0, 150.0, 230.0f, 256.0f);
float amps[5] =  float[5](0.0008f, 0.0008f, 0.0007f, 0.0005f, 0.0005f);
float phis[5] = float[5](1.8f, 2.0f, 3.0f, 5.0f, 6.5f);
vec2  dirs[5] = vec2[5](vec2(0.0,1.0),vec2(0.5, 1.0),vec2(0.3, 1.0),vec2(0.4, 1.0),vec2(-0.2, 1.0));
float exps[5] = float[5](1.0, 2.0, 2.0, 1.0, 1.0);
float fades[5] = float[5](0.0, 1.0/5.0, 1.0/5.0, 2.0, 2.0);
float sinWave[5] = float[5](0, 0, 0, 0, 0);
float ddx[5] = float[5](0, 0, 0, 0, 0);
float ddy[5] = float[5](0, 0, 0, 0, 0);

vec2 interpolate2D(vec2 v0, vec2 v1, vec2 v2, vec2 v3)
{
    vec2 xlerp1 = mix(v0, v1, gl_TessCoord.x);
    vec2 xlerp2 = mix(v3, v2, gl_TessCoord.x);

    return mix(xlerp1, xlerp2, gl_TessCoord.y);
}

vec3 interpolate3D(vec3 v0, vec3 v1, vec3 v2, vec3 v3)
{
    vec3 xlerp1 = mix(v0, v1, gl_TessCoord.x);
    vec3 xlerp2 = mix(v3, v2, gl_TessCoord.x);

    return mix(xlerp1, xlerp2, gl_TessCoord.y);
}

void main()
{
    for(int i = 0; i < 5; i++){
       dirs[i] = normalize(dirs[i]);
    }

    // Interpolate the attributes of the output vertex using the barycentric coordinates
    uv_G = interpolate2D(uv_TE[0], uv_TE[1], uv_TE[2], uv_TE[3]);
    vec3 vpoint_G = interpolate3D(vpoint_TE[0], vpoint_TE[1], vpoint_TE[2], vpoint_TE[3]);

    for(int i = 0; i < 5; i++){

        float waveParam = (dot(dirs[i], uv_G) * freqs[i]) + (phis[i] * time);

        //Bring sin in [0,1] for later exponentiation
        float sinTmp = (sin(waveParam) + 1.0)/2.0;

        //First sin^k, then bring back to [-1, 1] and multiply by amplitude
        sinWave[i] = amps[i] * ( 2.0 * pow(sinTmp, exps[i])-1.0);

        //Compute derivate of the wave
        float commonPartialDerivative = exps[i]  * freqs[i] * amps[i] * pow(sinTmp, exps[i]-1.0) * cos(waveParam);
        ddx[i] = dirs[i].x * commonPartialDerivative;
        ddy[i] = dirs[i].y * commonPartialDerivative;
    }

    vec3 waveNormal = vec3(0.0);
    for(int i = 0; i < 5; i++){
        vpoint_G.y += sinWave[i];
        waveNormal += vec3(-ddx[i], 1.0, ddy[i]);
    }

    vec3 rippleNormal =  texture(normalMap, (uv_G + vec2(0.0, 0.01 * time))* 5.0).rgb * 2.0 - 1.0f;
    rippleNormal = vec3(rippleNormal.x, rippleNormal.z, -rippleNormal.y);
    waveNormal = normalize(waveNormal + 0.7 * rippleNormal);

    //Flat normal is the projection of the wave normal onto the mirror surface
    vec3 flatNormal = waveNormal - dot(waveNormal, vec3(0.0, 1.0, 0.0)) * vec3(0.0, 1.0, 0.0);

    //Compute how the flat normal look in camera space
    vec3 eyeNormal = (NORMALM * vec4(flatNormal, 1.0)).xyz;

    //Compute distortion
    reflectOffset_G = normalize(eyeNormal.xy) * length (flatNormal) * 0.3;

    // Set height for generated (and original) vertices
    gl_Position = vec4(vpoint_G, 1.0);

    //Pass wave normal to geometry shader
    waveNormal_G = waveNormal;
}
