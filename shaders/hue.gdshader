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

void fragment() {
	COLOR.rgb = hue2rgb(UV.x);
}
