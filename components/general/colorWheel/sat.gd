extends ColorRect

func _process(delta: float) -> void:
	if Input.is_action_pressed("mbl") and isHovered:
		var satXYValue = get_local_mouse_position() / size
		Global.currentColor.s = satXYValue.x
		Global.currentColor.v = 1.0 - satXYValue.y
	material.set_shader_parameter("hue", Global.currentColor.h)
	$satpointer.position = Vector2(Global.currentColor.s, 1.0 - Global.currentColor.v) * size

var isHovered = false
func _on_mouse_entered() -> void:
	isHovered = true
func _on_mouse_exited() -> void:
	isHovered = false
