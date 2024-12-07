extends Control

func _process(delta: float) -> void:
	var center = size / 2
	var point = center.angle_to_point(get_global_mouse_position())
	var pointDeg = rad_to_deg(point)
	var hue = 0
	if pointDeg > 0: hue = pointDeg / 360.0
	else: hue = 1.0 + pointDeg / 360.0
	
	var radius = size.y / 2.35
	$pointer.pivot_offset = $pointer.size / 2
	$pointer.position.x = (radius * cos(point)) + (size.x / 2) - ($pointer.size.x / 2)
	$pointer.position.y = (radius * sin(point)) + (size.y / 2) - ($pointer.size.y / 2)
	$pointer.rotation = point
	
	#$pointer.color = Color.from_hsv(hue, 1.0, 1.0, 1.0)
