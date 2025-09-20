#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float iTime;

// Dynamic parameters - MUST match order in shader_config.dart
uniform float u_frequency;   // loc 3
uniform float u_speed;       // loc 4
uniform float u_amplitude;   // loc 5

vec2 iResolution;
out vec4 fragColor;

// Calculates a ripple wave from a given origin
float create_ripple(vec2 uv, vec2 origin, float time_offset, float speed, float frequency) {
    // Animate the ripple over time
    float time = iTime * speed + time_offset;
    // Get the distance from the origin
    float dist = length(uv - origin);
    // Create a sine wave based on distance and time
    return sin(dist * frequency - time);
}

void main(void) {
    iResolution = uSize;
    vec2 fragCoord = FlutterFragCoord();
    vec2 uv = fragCoord / iResolution.xy;

    // --- Multiple Ripple Sources ---
    // We will sum the effects of several ripples

    // Ripple 1 (center)
    float r1 = create_ripple(uv, vec2(0.5, 0.5), 0.0, u_speed, u_frequency);

    // Ripple 2
    float r2 = create_ripple(uv, vec2(0.2, 0.3), 1.5, u_speed, u_frequency);

    // Ripple 3
    float r3 = create_ripple(uv, vec2(0.8, 0.7), 2.5, u_speed, u_frequency);

    // Combine the ripples to create an interference pattern
    float total_ripple = r1 + r2 + r3;

    // --- Apply the effect ---
    vec2 uv2 = uv;
    // Use the combined ripple value to distort the texture coordinates
    uv2 += u_amplitude * total_ripple;

    // Create a grid pattern that gets distorted by the ripples
    float point = 0.01 / length(mod(uv2, 1.0) - 0.5);

    vec3 color = vec3(point);

    // Fade the effect out from the center for a vignette look
    float l = length(uv - 0.5);

    // Final color, with corrected alpha
    fragColor = vec4(color / l, 1.0);
}
