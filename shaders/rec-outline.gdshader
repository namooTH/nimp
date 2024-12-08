// thanks to https://godotshaders.com/shader/animated-selection-rectangle-marching-ants/

shader_type canvas_item;
uniform float outline_width = 6.0;

float rec_stroke(vec2 uv, float width)
{
    vec2 fw = fwidth(uv);
    float line_width = min(width, min(0.5 / fw.x, 0.5 / fw.y));
    vec2 aw = fw * line_width;
    vec2 cond = (sign(abs(uv - 0.5) - 0.5 + aw) + 1.0) * 0.5 * ceil(((sign(uv.yx - aw.yx) + 1.0) * 0.5 * (sign(uv - 0.5) * vec2(0.5, -0.5) + 0.5) * 0.5 + (sign(1.0 - aw.yx - uv.yx) + 1.0) * 0.5 * (sign(uv - 0.5) * vec2(-0.5, 0.5)+ 0.5) * 0.5));
    float dir = dot(vec2(cond.y, -cond.x), sign(uv.yx - 0.5) * uv / aw);
	return (cond.x + cond.y);
}

void fragment() {
    COLOR = rec_stroke(UV, outline_width) * COLOR;
}