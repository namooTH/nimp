extends ColorRect

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mbl") and isHovered:
		var center = size / 2
		var point = center.angle_to_point(get_local_mouse_position())
		var pointDeg = rad_to_deg(point)
		Global.currentColor.h = 1.0
		if pointDeg > 0: Global.currentColor.h = pointDeg / 360.0
		else: Global.currentColor.h = 1.0 + pointDeg / 360.0

func _process(delta: float) -> void:
	# adjusing the pointer
	var pointer = $pointer
	var radius = size.y / 2.35
	var point = deg_to_rad(360 * Global.currentColor.h)
	
	# making sure that it isnt a blob on low resolution
	pointer.material.set_shader_parameter("outline_width", 3.0 * (size.x / size.y))
	
	pointer.pivot_offset = pointer.size / 2
	pointer.position.x = (radius * cos(point)) + (size.x / 2) - (pointer.size.x / 2)
	pointer.position.y = (radius * sin(point)) + (size.y / 2) - (pointer.size.y / 2)
	pointer.rotation = point

var isHovered = false
func _on_mouse_entered() -> void:
	isHovered = true
func _on_mouse_exited() -> void:
	isHovered = false
