#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float iTime;

// Dynamic parameters - MUST match order in shader_config.dart
uniform float u_frequency;   // loc 3
uniform float u_speed;       // loc 4
uniform float u_point_size;  // loc 5

vec2 iResolution;

out vec4 fragColor;

void main(void) {
    iResolution = uSize;
    vec2 fragCoord = FlutterFragCoord();
    vec2 uv = fragCoord / iResolution.xy;

    float l = iTime;
    vec2 uv2, p = uv;
    uv2 = p;
    p -= .5;
    l = length(p);
    uv2 += abs(sin(l * u_frequency - (iTime * u_speed)));
    float point = u_point_size / length(mod(uv2, 1.) - .5);

    vec3 c = vec3(point);

    fragColor = vec4(c / l, 1.0); // Corrected alpha from original
}