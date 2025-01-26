extends Control

var lastMousePos = null
var isHovered = false
var isClicked = false

var isResizing: bool = false
func _process(delta: float) -> void:
	var selected = SelectionManager.getSelectedNode()
	if is_instance_valid(selected):
		show()
		size = selected.size * Global.currentCamera.zoom
		position = selected.get_global_transform_with_canvas().get_origin()
	else: hide()

var stillClickCounter:int = 0 
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mbl"):
		if visible and not isHovered and not is_instance_valid(FocusManager.getFocusNode()):
			FocusManager.unfocusCurrent()
			SelectionManager.deselectCurrentSelection()
		isClicked = true
	if event.is_action_released("mbl"):
		FocusManager.unfocusCurrent()
		isClicked = false
	if event is InputEventMouseMotion or event is InputEventKey:
		var tranfrom
		if lastMousePos: tranfrom = get_global_mouse_position() - lastMousePos
		else: return
		if isClicked and tranfrom != Vector2.ZERO:
			stillClickCounter = 0
			move(tranfrom)
		else:
			if !is_instance_valid(SelectionManager.getSelectedNode()): return
			if event.is_action_pressed("left"): SelectionManager.getSelectedNode().position.x -= 1
			if event.is_action_pressed("right"): SelectionManager.getSelectedNode().position.x += 1
			if event.is_action_pressed("up"): SelectionManager.getSelectedNode().position.y -= 1
			if event.is_action_pressed("down"): SelectionManager.getSelectedNode().position.y += 1
	elif isClicked and isHovered:
		stillClickCounter += 1
		if stillClickCounter >= 2:
			stillClickCounter = 0
			SelectionManager.getSelectedNode().action()
	lastMousePos = get_global_mouse_position()

func _on_mouse_entered() -> void: isHovered = true
func _on_mouse_exited() -> void: isHovered = false

func move(tranfrom: Vector2):
	if FocusManager.getFocusNode(): resize(SelectionManager.getSelectedNode(), FocusManager.getFocusNode(), tranfrom / Global.currentCamera.zoom)
	else: if isHovered: SelectionManager.getSelectedNode().position += tranfrom / Global.currentCamera.zoom
func resize(target: Node, selection_node: Node, tranform: Vector2):
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
