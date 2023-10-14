#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float iTime;
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
    uv2 += abs(sin(l * 10. - iTime));
    float point = .01 / length(mod(uv2, 1.) - .5);

    vec3 c = vec3(point);

    fragColor = vec4(c / l, iTime);
}