shader_type canvas_item;

// code from https://www.statox.fr/posts/2021/04/color_picker_shaders/?utm_campaign=color_picker_demo
// https://gist.github.com/yiwenl/745bfea7f04c456e0101
vec3 hsb2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

float circle(vec2 position, float radius)
{
	// the original code in godot shaders was wrong
	// the right code https://thebookofshaders.com/glossary/?search=dot has the position subtracted by 0.5
	float square = step(1.0, max(position.x, position.y));
	return smoothstep(radius, radius, dot( position - vec2(0.5), position - vec2(0.5) ) * 2.0);
}

// from https://godotshaders.com/snippet/polar-coordinates/
vec2 polar_coordinates(vec2 uv, vec2 center, float zoom, float repeat)
{
	vec2 dir = uv - center;
	float radius = length(dir) * 2.0;
	float angle = atan(dir.y, dir.x) * 1.0/(3.1416 * 2.0);
	return mod(vec2(radius * zoom, angle * repeat), 1.0);
}

void fragment() {
	vec2 polar_uv = polar_coordinates(UV.xy, vec2(0.5), 0.0, 1.0);
	COLOR.a = 0.0;
	if (circle(UV, 0.45) == 0.0) {
		COLOR.rgb = hsb2rgb(vec3(polar_uv.y, 1, 1));
		COLOR.a = 1.0;
	};
}
