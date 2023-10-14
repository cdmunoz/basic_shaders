//https://www.shadertoy.com/view/4sX3R2
#include <flutter/runtime_effect.glsl>

#define AA 1

vec2 hash2(float n)
{
    return fract(sin(vec2(n, n + 1.0)) * vec2(13.5453123, 31.1459123));
}

vec3 hash3(float n)
{
    return fract(sin(vec3(n, n + 1.0, n + 2.0)) * vec3(13.5453123, 31.1459123, 37.3490423));
}

vec3 noise(in float x)
{
    float p = floor(x);
    float f = fract(x);
    f = f * f * (3.0 - 2.0 * f);
    return mix(hash3(p + 0.0), hash3(p + 1.0), f);
}


mat4 rotationMat(in vec3 xyz)
{
    vec3 si = sin(xyz);
    vec3 co = cos(xyz);

    return mat4(co.y * co.z, co.y * si.z, -si.y, 0.0,
                si.x * si.y * co.z - co.x * si.z, si.x * si.y * si.z + co.x * co.z, si.x * co.y, 0.0,
                co.x * si.y * co.z + si.x * si.z, co.x * si.y * si.z - si.x * co.z, co.x * co.y, 0.0,
                0.0, 0.0, 0.0, 1.0);
}

const float s = 1.18;

mat4 mm;

vec3 map(vec3 p)
{
    float k = 1.0;
    float m = 1e10;
    for (int i = 0; i < 22; i++)
    {
        m = min(m, dot(p, p) / (k * k));
        p = (mm * vec4((abs(p)), 1.0)).xyz;
        k *= s;
    }


    float d = (length(p) - 0.25) / k;

    float h = p.z - 0.35 * p.x;

    return vec3(d, m, h);
}

vec3 intersect(in vec3 ro, in vec3 rd)
{
    float t = 0.0;
    for (int i = 0; i < 100; i++)
    {
        vec3 res = map(ro + rd * t);
        if (res.x < 0.0002) return vec3(t, res.yz);
        t += res.x;
        if (t > 9.0) break;
    }

    return vec3(-1.0);
}

vec3 calcNormal(in vec3 pos, float e)
{
    vec3 eps = vec3(e, 0.0, 0.0);

    return normalize(vec3(
                         map(pos + eps.xyy).x - map(pos - eps.xyy).x,
                         map(pos + eps.yxy).x - map(pos - eps.yxy).x,
                         map(pos + eps.yyx).x - map(pos - eps.yyx).x));
}

float softshadow(in vec3 ro, in vec3 rd, float mint, float k)
{
    float res = 1.0;
    float t = mint;
    for (int i = 0; i < 32; i++)
    {
        float h = map(ro + rd * t).x;
        h = max(h, 0.0);
        res = min(res, k * h / t);
        t += clamp(h, 0.001, 0.1);
        if (res < 0.01 || t > 6.0) break;
    }
    return clamp(res, 0.0, 1.0);
}

float calcAO(in vec3 pos, in vec3 nor)
{
    float totao = 0.0;
    for (int aoi = 0; aoi < 16; aoi++)
    {
        vec3 aopos = -1.0 + 2.0 * hash3(float(aoi) * 213.47);
        aopos *= sign(dot(aopos, nor));
        aopos = pos + nor * 0.01 + aopos * 0.04;
        float dd = clamp(map(aopos).x * 4.0, 0.0, 1.0);
        totao += dd;
    }
    totao /= 16.0;

    return clamp(totao * totao * 50.0, 0.0, 1.0);
}

mat3 setCamera(in vec3 ro, in vec3 ta, float cr)
{
    vec3 cw = normalize(ta - ro);
    vec3 cp = vec3(sin(cr), cos(cr), 0.0);
    vec3 cu = normalize(cross(cw, cp));
    vec3 cv = normalize(cross(cu, cw));
    return mat3(cu, cv, cw);
}

uniform vec2 uSize;
uniform sampler2D image;
uniform float iTime;
//uniform vec4 iMouse;
vec2 iResolution;

out vec4 fragColor;

void mainImage()
{
    iResolution = uSize;
    vec2 fragCoord = FlutterFragCoord();
    // animation
    float rtime = iTime;

    float time = rtime;
    time += 15.0 * smoothstep(15.0, 25.0, rtime);
    time += 20.0 * smoothstep(65.0, 80.0, rtime);
    time += 35.0 * smoothstep(105.0, 135.0, rtime);
    time += 20.0 * smoothstep(165.0, 180.0, rtime);
    time += 40.0 * smoothstep(220.0, 290.0, rtime);
    time += 5.0 * smoothstep(320.0, 330.0, rtime);
    float time1 = (time - 10.0) * 1.5 - 167.0;
    float time2 = time;

    mm = rotationMat(vec3(0.4, 0.1, 3.4) +
                     0.15 * sin(0.1 * vec3(0.40, 0.30, 0.61) * time1) +
    0.15 * sin(0.1 * vec3(0.11, 0.53, 0.48) * time1));
    mm[0].xyz *= s;
    mm[1].xyz *= s;
    mm[2].xyz *= s;
    mm[3].xyz = vec3(0.15, 0.05, -0.07) + 0.05 * sin(vec3(0.0, 1.0, 2.0) + 0.2 * vec3(0.31, 0.24, 0.42) * time1);


    // camera
    vec2 m = vec2(0.5);
    //if (iMouse.z > 0.0) m = iMouse.xy / iResolution.xy;
    float an = 1.0 + 0.1 * time2 - 6.2 * m.x;
    float cr = 0.15 * sin(0.2 * time2);
    vec3 ro = (2.4 + 0.6 * smoothstep(10.0, 20.0, time2)) * vec3(sin(an), 0.25, cos(an));
    vec3 ta = vec3(0.0, 0.0 + 0.13 * cos(0.3 * time2), 0.0);
    ta += 0.05 * noise(0.0 + 1.0 * time);
    ro += 0.05 * noise(11.3 + 1.0 * time);
    // camera-to-world transformation
    mat3 ca = setCamera(ro, ta, cr);

    vec3 tot = vec3(0.0);
    #if AA > 1
    for (int m = 0; m < AA; m++)
    for (int n = 0; n < AA; n++)
    {
        vec2 of = -0.5 + vec2(float(m), float(n)) / float(AA);
        vec2 q = (fragCoord + of) / iResolution.xy;
        #else
        vec2 q = fragCoord / iResolution.xy;
        #endif
        vec2 p = -1.0 + 2.0 * q;
        p.x *= iResolution.x / iResolution.y;

        // ray direction
        vec3 rd = ca * normalize(vec3(p.xy, 3.0));

        // raymarch
        vec3 tmat = intersect(ro, rd);

        // shade
        vec3 col = vec3(0.0);
        if (tmat.z > -0.5)
        {
            // geometry
            vec3 pos = ro + tmat.x * rd;
            vec3 nor = calcNormal(pos, 0.005);
            vec3 sor = calcNormal(pos, 0.010);

            // material
            vec3 mate = vec3(1.0);
            mate = mix(vec3(0.5, 0.5, 0.2), vec3(0.5, 0.3, 0.0), 0.5 + 0.5 * sin(4.0 + 8000.0 * tmat.y));
            mate = mix(vec3(1.0, 0.9, 0.8), mate, 0.5 + 0.5 * sin(4.0 + 20.0 * tmat.z));
            mate.x *= 1.15;

            // lighting
            float occ = 1.1 * calcAO(pos, nor);
            occ *= 0.75 + 0.25 * clamp(tmat.y * 400.0, 0.0, 1.0);

            // diffuse
            col = vec3(0.0);
            for (int i = 0; i < 32; i++)
            {
                //vec3 rr = normalize(-1.0 + 2.0*texture( iChannel2, vec2((0.5+float(i)),0.5)/256.0,-100.0).xyz);
                vec3 rr = normalize(-1.0 + 2.0 * hash3(float(i) * 123.5463));
                rr = normalize(nor + 7.0 * rr);
                rr = rr * sign(dot(nor, rr));
                float ds = occ;//softshadow( pos, rr, 0.01, 32.0 );
                col += pow(texture(iChannel0, rr).xyz, vec3(2.2)) * dot(rr, nor) * ds;
            }
            col /= 32.0;

            col *= 1.8;

            // subsurface
            col *= 1.0 + 1.0 * vec3(1.0, 0.6, 0.1) * pow(clamp(1.0 + dot(rd, sor), 0.0, 1.0), 2.0) * vec3(1.0);

            // specular
            float fre = pow(clamp(1.0 + dot(rd, nor), 0.0, 1.0), 5.0);
            vec3 ref = reflect(rd, nor);
            float rs = softshadow(pos, ref, 0.01, 32.0);
            col += 1.8 * (0.04 + 12.0 * fre) * occ * pow(texture(iChannel0, ref).xyz, vec3(2.0)) * rs;

            col *= mate;
        }
        else
        {
            // background
            col = pow(texture(iChannel0, rd).xyz, vec3(2.2));
        }
        tot += col;
        #if AA > 1
    }
    tot /= float(AA * AA);
    #endif

    // gamma
    tot = pow(clamp(tot * 1.5, 0.0, 1.0), vec3(0.45));

    // vigneting
    {
        vec2 q = fragCoord / iResolution.xy;
        tot *= 0.5 + 0.5 * pow(16.0 * q.x * q.y * (1.0 - q.x) * (1.0 - q.y), 0.1);
    }

    fragColor = vec4(tot, 1.0);
}