# Procedural terrain generation with OpenGL

<img width="640" alt="main_2017-05-31_21-32-54" src="https://user-images.githubusercontent.com/11776282/33839297-19030b4c-de92-11e7-8de0-1b65f8e7d801.png">

This project was completed for the “Introduction to computer graphics” course.  The course focused on rendering techniques and their theoretical basis while leaving to the students the task to learn how to actually implement those techniques in OpenGL. The initial goal was to generate a landscape using procedural techniques and add some basic lighting effects to it.

Several features were implemented in addition to the basic requirements:

* Infinite terrain generation
* Dynamic shadows
* Adaptive level of details through the use of tessellation
* Instantiated patches of grass
* 3D model loading
* Dynamic sky which mimics the natural colour changes throughout the day

See the screenshots of completed project below:

Patches of grass appear when appropriate terrain conditions are met.
![main_2017-05-31_21-06-18](https://user-images.githubusercontent.com/11776282/33839303-1a16930a-de92-11e7-99e2-73b210dd0d02.jpg)


Enjoying a virtual sunset. Note how the mountains cast their shadows onto the water surface.

![main_2017-05-29_21-17-58](https://user-images.githubusercontent.com/11776282/33839302-19e62cba-de92-11e7-9732-24a2b3688c63.jpg)


Reflections on the water surface vary over time depending on the waves and ripples.

![main_2017-05-29_21-16-55](https://user-images.githubusercontent.com/11776282/33839300-196839ea-de92-11e7-945b-8378f73f518d.jpg)

The terrain regenerates indefinitely when the user traverse the landscape. Mountains far away are faded to hide the regeneration process while at the same time giving the illusion of distance.

![main_2017-05-29_21-15-50](https://user-images.githubusercontent.com/11776282/33839298-1934feea-de92-11e7-9539-0a0dca2b0f8b.jpg)


Tessellation allows adjusting the level of detail of the terrain based on the distance to the observer and the importance of a given zone. Note how little geometry is used for the underwater part.

![main_2017-06-21_11-00-33](https://user-images.githubusercontent.com/11776282/33839295-18d02ff6-de92-11e7-9c0f-eec77de7dda2.jpg)


The terrain is generated using Perlin noise based methods
<img src="https://lkieliger.ch/docs/pictures/cgx/terrainCompil1.jpg" alt="Perlin noise variations" />

<img src="https://lkieliger.ch/docs/pictures/cgx/terrainCompil2.jpg"  alt="Perlin noise variations" />


