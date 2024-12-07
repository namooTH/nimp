shader_type canvas_item;

vec4 square_stroke(vec2 uv, float width, float stroke_width)
{
	uv = uv * 2.0 - 1.0;

	vec2 abs_uv = abs(uv.xy);
	float dist = max(abs_uv.x, abs_uv.y);
	vec3 stroke = 1.0 - vec3( step(width, dist) - step(width + stroke_width, dist) );
	return vec4(vec3(stroke), 1.0);
}

void fragment() {
	COLOR.a = 0.0;
	COLOR = square_stroke(UV, 0.8, 0.2);
}
