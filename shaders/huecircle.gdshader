shader_type canvas_item;

vec3 hue2rgb(float hue) {
	hue = fract(hue); //only use fractional part of hue, making it loop
    float r = abs(hue * 6.0 - 3.0) - 1.0; //red
    float g = 2.0 - abs(hue * 6.0 - 2.0); //green
    float b = 2.0 - abs(hue * 6.0 - 4.0); //blue
    vec3 rgb = vec3(r,g,b); //combine components
    rgb = clamp(rgb, 0.0, 1.0); //clamp between 0 and 1
    return rgb;
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
		COLOR.rgb = hue2rgb(polar_uv.y);
		COLOR.a = 1.0;
	};
}
