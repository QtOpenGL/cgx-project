cmake_minimum_required(VERSION 2.8)
project(icg17-private)

# load the common ICG configuration
include(common/icg_settings.cmake)

LINK_DIRECTORIES(C:/Assimp/lib)
INCLUDE_DIRECTORIES(C:/Assimp/include)

# week 1
#add_subdirectory(lab1_helloworld)

# week 2
#add_subdirectory(lab2_intro_to_glsl)
#add_subdirectory(hw2p1_spiral)
#add_subdirectory(hw2p2_checkerboard)
#add_subdirectory(hw2p3_planets)

# week 3
#add_subdirectory(lab3_opengl3d)
add_subdirectory(main)
