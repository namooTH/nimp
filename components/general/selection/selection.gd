extends Control

var lastMousePos = null
var allowMove = false
var allowResize = false
var isClicked = false

var selectedNode = null
func select(node: Control):
	selectedNode = node
var isResizing: bool = false
func _process(delta: float) -> void:
	if is_instance_valid(selectedNode):
		size = selectedNode.size * Global.currentZoomLevel
		position = selectedNode.get_global_transform_with_canvas().get_origin()
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
			if FocusManager.getFocusNode(): resize_window(selectedNode, FocusManager.getFocusNode(), tranfrom / Global.currentZoomLevel)
			else: if allowMove: selectedNode.position += tranfrom / Global.currentZoomLevel
			isResizing = true

func _on_mouse_entered() -> void:
	allowMove = true
func _on_mouse_exited() -> void:
	allowMove = false

func resize_window(target: Node, selection_node: Node, tranform: Vector2):
	match selection_node.name:
		"SelectionCircleLeftCenter":
			target.size.x += -tranform.x
			target.position.x += tranform.x
		"SelectionCircleLeftBottom":
			target.size.x += -tranform.x
			target.position.x += tranform.x
			target.size.y += tranform.y
		"SelectionCircleLeftTop":
			target.size.y += -tranform.y
			target.position.y += tranform.y
			target.size.x += -tranform.x
			target.position.x += tranform.x
		"SelectionCircleRightCenter":
			target.size.x += tranform.x
		"SelectionCircleRightBottom":
			target.size.x += tranform.x
			target.size.y += tranform.y
		"SelectionCircleRightTop":
			target.size.x += tranform.x
			target.size.y += -tranform.y
			target.position.y += tranform.y
		"SelectionCircleBottomCenter":
			target.size.y += tranform.y
		"SelectionCircleTopCenter":
			target.size.y += -tranform.y
			target.position.y += tranform.y
