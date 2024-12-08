shader_type canvas_item;
uniform float hue;

// https://gist.github.com/yiwenl/745bfea7f04c456e0101
vec3 hsb2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
	// flip y because thats just how godot works
	// also because most color picker looks this way
    vec3 color = hsb2rgb(vec3(hue, UV.x, 1.0 - UV.y));
    COLOR = vec4(color, 1.0);
}