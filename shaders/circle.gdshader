shader_type canvas_item;

float circle(vec2 position, float radius)
{
	// the original code in godot shaders was wrong
	// the right code https://thebookofshaders.com/glossary/?search=dot has the position subtracted by 0.5
	float square = step(1.0, max(position.x, position.y));
	return smoothstep(radius, radius, dot( position - vec2(0.5), position - vec2(0.5) ) * 2.0);
}

void fragment() {
	if (circle(UV, 0.45) != 0.0) ( COLOR.a = 0.0 );
}
