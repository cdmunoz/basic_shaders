#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform vec2 uSize;
uniform sampler2D image;
uniform float iTime;
uniform float u_pixelation;
uniform float u_wave_freq;
uniform float u_wave_amp;


float inverseLerp(float v, float minValue, float maxValue) {
    return (v - minValue) / (maxValue - minValue);
}

float remap(float v, float inMin, float inMax, float outMin, float outMax) {
    float t = inverseLerp(v, inMin, inMax);
    return mix(outMin, outMax, t);
}

void main() {
    vec2 iResolution = uSize;
    vec2 fragCoord = FlutterFragCoord();
    vec2 uv = fragCoord / iResolution.xy;

    // Vignette
    vec3 col = texture(image, uv).xyz;
    vec2 vignetteCoords = fract(uv * vec2(1.0, 1.0));
    float v1 = smoothstep(0.5, 0.2, abs(vignetteCoords.x - 0.5));
    float v2 = smoothstep(0.5, 0.2, abs(vignetteCoords.y - 0.5));
    float vignetteAmount = v1 * v2;
    vignetteAmount = pow(vignetteAmount, 0.45);
    vignetteAmount = remap(vignetteAmount, 0.0, 1.0, 0.5, 1.0);

    // Pixelation
    vec2 dims = vec2(u_pixelation, u_pixelation / 2.0);
    vec2 texUV = floor(uv * dims) / dims;
    vec3 pixelated = texture(image, texUV).xyz;

    // Ripples
    float distToCenter = length(uv - 0.5);
    float d = sin(distToCenter * u_wave_freq - iTime * 2.0);
    vec2 dir = normalize(uv - 0.5);
    // To combine effects, we distort the pixelated coordinates
    vec2 rippleCoords = texUV + d * dir * u_wave_amp;
    col = texture(image, rippleCoords).xyz;

    // Output to screen
    fragColor = vec4(col, 1.0);
}