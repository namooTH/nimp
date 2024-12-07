extends Control

func _unhandled_input(event: InputEvent) -> void: if event.is_action_pressed("mbl") and isMouseHovered:
	move_to_front()
	SelectionManager.requiresSelection(self)
var isMouseHovered = false
func _on_mouse_entered() -> void: isMouseHovered = true
func _on_mouse_exited() -> void: isMouseHovered = false
