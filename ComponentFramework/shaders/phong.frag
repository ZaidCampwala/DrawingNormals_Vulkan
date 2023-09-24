#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(binding = 1) uniform GlobalLightingUBO{
vec4 position[2];
vec4 diffuse[2];
} glights;

layout(location = 0) in vec3 vertNormal;
layout(location = 1) in vec3 lightDir[2];
layout(location = 3) in vec3 eyeDir;
layout(location = 4) in vec2 fragTexCoord;

layout(location = 0) out vec4 outColor;

layout(binding = 2) uniform sampler2D texSampler;

void main() {

	vec4 kt = texture(texSampler, fragTexCoord);
	vec4 ka = 0.1*kt;

	outColor = ka;
	for(int i = 0; i<2; i++){
		vec4 kd = glights.diffuse[i];
		vec4 ks = glights.diffuse[i];

		float diff = max(dot(vertNormal, lightDir[i]), 0.0);
		vec3 reflection = normalize(reflect(-lightDir[i], vertNormal));
		float spec = max(dot(eyeDir,reflection), 0.0);
		spec = pow(spec,14.0);
		outColor += diff * (kt + kd) + spec * ks;
	}
}