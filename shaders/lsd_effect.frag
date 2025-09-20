#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float iTime;
vec2 iResolution;

out vec4 fragColor;

#define PI 3.1415926535897932384626433832795

uniform float u_num_stripes;
uniform float u_dist_freq;

void main(void) {

    iResolution = uSize;
    vec2 fragCoord = FlutterFragCoord();

    vec2 center = fragCoord / iResolution.xy - vec2(0.5, 0.5);

    float dist = length(center);
    float p = (atan(center.y, center.x)) / (2.0 * PI);

    bool stripeA = mod(floor((p * u_num_stripes) + (sin(dist * u_dist_freq + sin(iTime)))), 2.0) == 1.0;
    bool stripeB = mod(floor((p * u_num_stripes) - (sin(dist * u_dist_freq + cos(iTime)))), 2.0) == 1.0;

    vec3 col;

    if (stripeA && stripeB)
    {
        col = vec3(0.6);
    }
    else if (!stripeA && stripeB)
    {
        col = vec3(0.25, 0.4, 0.2);
    }
    else if (stripeA && !stripeB)
    {
        col = vec3(0.6, 0.4, 0.2);
    }
    else
    {
        col = vec3(0.9);
    }

    fragColor = vec4(col, 0.5);
}