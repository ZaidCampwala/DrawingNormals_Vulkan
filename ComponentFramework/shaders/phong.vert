#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(location = 0) in vec4 vVertex;
layout(location = 1) in vec3 vNormal;
layout(location = 2) in vec2 inTexCoord;

layout(binding = 0) uniform CameraUBO {
    mat4 view;
    mat4 proj;
} camera;

layout(binding = 1) uniform GlobalLightningUBO{
    vec4 lightPos[2];
    vec4 lightColor[2];
} glight;

layout(push_constant) uniform Push{
    mat4 modelMatrix;
    mat4 normalMatrix;
} push;

layout(location = 0) out vec3 vertNormal;
layout(location = 1) out vec3 lightDir[2];
layout(location = 3) out vec3 eyeDir;
layout(location = 4) out vec2 fragTexCoord;

void main() {
    fragTexCoord = inTexCoord;
    mat3 normalMatrix = mat3(push.normalMatrix);

    vertNormal = normalize(normalMatrix*vNormal.xyz);

    vec3 vertPos = vec3(camera.view*push.modelMatrix*vVertex);
    vec3 vertDir = normalize(vertPos);
    eyeDir = -vertDir;
    lightDir[0] = normalize(vec3(glight.lightPos[0])-vertPos);
    lightDir[1] = normalize(vec3(glight.lightPos[1])-vertPos);
    gl_Position = camera.proj * camera.view * push.modelMatrix * vVertex;
}