#version 330 core
// Specify the GLSL version. 330 core is a common modern version.

// Vertex shader inputs (attributes)
// 'in vec3 aPos' declares an input attribute named 'aPos' of type vec3 (3D
// vector of floats). 'layout (location = 0)' specifies that this attribute will
// be located at index 0 when setting up vertex attributes in the OpenGL
// application.
layout(location = 0) in vec3 aPos;

// Vertex shader outputs (varyings)
// In this simple example, we don't have any varyings to pass to the fragment
// shader, but in more complex shaders, you would declare 'out' variables here.

// Uniform variables (global variables passed from the OpenGL application)
// In this simple example, we don't use any uniforms,
// but they are often used for matrices, colors, etc.

// The main function, which is executed for each vertex
void main() {
  // gl_Position is a built-in output variable in vertex shaders.
  // It determines the final vertex position in clip space, which is used for
  // rendering.

  // In this very simple shader, we are just passing the input vertex position
  // 'aPos' directly as the output vertex position 'gl_Position'.
  // 'vec4(aPos, 1.0)' converts the vec3 'aPos' to a vec4 by adding a
  // w-component of 1.0. The w-component is necessary for perspective division
  // in the later pipeline stages.

  gl_Position = vec4(aPos, 1.0);
}
