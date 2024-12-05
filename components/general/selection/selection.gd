extends Control

var lastMousePos = null
var allowMove = false
var allowResize = false
var isClicked = false

var selectedNode = null
func select(node: Control):
	selectedNode = node
	position = selectedNode.get_global_transform_with_canvas().get_origin()
	size = selectedNode.size * Global.currentZoomLevel
func _process(delta: float) -> void:
	if is_instance_valid(selectedNode):
		if isClicked:
			selectedNode.size = size / Global.currentZoomLevel
			# https://www.reddit.com/r/godot/comments/11ujvgs/how_to_position_node2d_in_screen_coordinates/
			selectedNode.position = selectedNode.get_global_transform_with_canvas().get_origin() - position
		else:
			position = selectedNode.get_global_transform_with_canvas().get_origin()
			size = selectedNode.size * Global.currentZoomLevel
	
	
	lastMousePos = get_global_mouse_position()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mbl"):
		isClicked = true
	if event.is_action_released("mbl"):
		FocusManager.unfocusCurrent()
		isClicked = false
	if event is InputEventMouseMotion:
		var tranfrom
		if lastMousePos: tranfrom = get_global_mouse_position() - lastMousePos
		else: return
		if isClicked:
			if FocusManager.getFocusNode(): resize_window(FocusManager.getFocusNode(), tranfrom)
			else: if allowMove: position += tranfrom

func _on_mouse_entered() -> void:
	allowMove = true
func _on_mouse_exited() -> void:
	allowMove = false

func resize_window(selection_node: Node, tranform: Vector2):
	match selection_node.name:
		"SelectionCircleLeftCenter":
			size.x += -tranform.x
			position.x += tranform.x
		"SelectionCircleLeftBottom":
			size.x += -tranform.x
			position.x += tranform.x
			size.y += tranform.y
		"SelectionCircleLeftTop":
			size.y += -tranform.y
			position.y += tranform.y
			size.x += -tranform.x
			position.x += tranform.x
		"SelectionCircleRightCenter":
			size.x += tranform.x
		"SelectionCircleRightBottom":
			size.x += tranform.x
			size.y += tranform.y
		"SelectionCircleRightTop":
			size.x += tranform.x
			size.y += -tranform.y
			position.y += tranform.y
		"SelectionCircleBottomCenter":
			size.y += tranform.y
		"SelectionCircleTopCenter":
				size.y += -tranform.y
				position.y += tranform.y
