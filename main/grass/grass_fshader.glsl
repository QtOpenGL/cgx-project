#version 410 core
in vec2 uv;
in vec4 heightColor;
in vec2 vpoint_World_F;
out vec4 color;

uniform float max_vpoint_World_F;
uniform float threshold_vpoint_World_F;
uniform sampler2D grassAlpha;
uniform sampler2D heightMap;

void main() {
   vec4 color_value = texture(grassAlpha, vec2(uv.x, 1.05f - uv.y));
    if(color_value.a < 0.2){
        discard;
    }
    //color = texture(heightMap, uv);
    color = color_value;
    //color = heightColor;
    //color = texture(heightMap, uv);

    color.a *= 1 - smoothstep(threshold_vpoint_World_F, max_vpoint_World_F,
                              max(abs(vpoint_World_F.x), abs(vpoint_World_F.y))
                              );
}
