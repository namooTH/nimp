extends Control

func _unhandled_input(event: InputEvent) -> void:
	if SelectionManager.getSelectedNode() == self:
		if event.is_action_pressed("move-index-down"): get_parent().move_child(self, get_index() - 1)
		if event.is_action_pressed("move-index-up"): get_parent().move_child(self, get_index() + 1)
		if event.is_action_pressed("delete"): SelectionManager.queueFreeCurrentSelection()
	if event.is_action_pressed("mbl") and isMouseHovered: SelectionManager.requiresSelection(self)
var isMouseHovered = false
func _on_mouse_entered() -> void: isMouseHovered = true
func _on_mouse_exited() -> void: isMouseHovered = false
