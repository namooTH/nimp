extends ColorRect

var satXYValue: Vector2 = Vector2.ZERO
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mbl") and isHovered:
		satXYValue = get_local_mouse_position() / size
func _process(delta: float) -> void:
	$satpointer.position = satXYValue * size

var isHovered = false
func _on_mouse_entered() -> void:
	isHovered = true
func _on_mouse_exited() -> void:
	isHovered = false
