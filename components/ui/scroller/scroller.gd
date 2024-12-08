extends Control

@export var padding: Vector2 = Vector2(10,10)

var displayedNodes = []
var cachedDownNodes = []
var cachedUpperNodes = []

func _ready():
	for child in get_children(): checkNode(child) 

func calcTotalRect(nodes: Array) -> Rect2: 
	return Rect2(nodes[0].position, (nodes[-1].position + nodes[-1].size) - nodes[0].position)
func cullOutOfBoundsY():
	while len(displayedNodes) > 1 and displayedNodes[-1].position.y >= (self.size + displayedNodes[-1].size).y:
		displayedNodes[-1].hide()
		cachedDownNodes.append(displayedNodes[-1])
		displayedNodes.erase(displayedNodes[-1])
	while len(displayedNodes) > 1 and  displayedNodes[0].position.y <= -displayedNodes[0].size.y * 2:
		displayedNodes[0].hide()
		cachedUpperNodes.append(displayedNodes[0])
		displayedNodes.erase(displayedNodes[0])
func fillInNodesY():
	if not displayedNodes:
		return
	while cachedDownNodes and displayedNodes[-1].position.y + displayedNodes[-1].size.y <= self.size.y:
		displayedNodes.append(cachedDownNodes[-1])
		displayedNodes[-1].show()
		cachedDownNodes.pop_back()
	while cachedUpperNodes and displayedNodes[0].position.y >= 0:
		displayedNodes.insert(0, cachedUpperNodes[-1])
		displayedNodes[0].show()
		displayedNodes[0].position.y = -displayedNodes[0].size.y - padding.y
		cachedUpperNodes.pop_back()

#func insertNode(index: int = -1):
#	pass
#func sortNodes():
#	pass

var scrollVelocity: Vector2 = Vector2.ZERO
func _process(delta):
	#scrollVelocity -= 1
	#print(len(displayedNodes))

	#var fullRect = calcTotalRect(displayedNodes)
	#$debug_size.size = fullRect.size
	#$debug_size.position = fullRect.position
	
	cullOutOfBoundsY()
	fillInNodesY()

	smoothVelocity = lerp(smoothVelocity, Vector2.ZERO, delta * 5)
	if displayedNodes: displayedNodes[0].position.y += scrollVelocity.y + smoothVelocity.y
	#if absf(smoothVelocity.y) > 0.01 or scrollVelocity.y > 0.0:
	update()
	scrollVelocity = Vector2.ZERO

func update():
	var lastNode = null
	for node in displayedNodes:
		if lastNode:
			node.position.y = lastNode.position.y + lastNode.size.y + 10
			node.position.x = lastNode.position.x #+ lastNode.size.x
		lastNode = node
	
var smoothVelocity: Vector2 = Vector2.ZERO
var pressedPos
func _input(event):
	if event.is_action_pressed("mbl") and isHovered:
		pressedPos = event.position
	if event is InputEventMouseMotion and pressedPos:
		scrollVelocity = event.position - pressedPos
		pressedPos = event.position
	if event.is_action_released("mbl"):
		pressedPos = null
	if isHovered: smoothVelocity.y += (-event.get_action_strength("scroll_down") + event.get_action_strength("scroll_up")) * 2.0

func checkNode(node):
	if node in cachedDownNodes or node in cachedUpperNodes or node in displayedNodes:
		return
	
	if !"unrelated_" in node.name and !node is Control:
		var errormsg = "%s is NOT in the Control class." % node
		#GlobalMessage.appendLinuxStyleDebugText(["[color=red]BAD[/color]", errormsg])
		push_error(errormsg)
		return
	if not "unrelated_" in node.name:
		displayedNodes.append(node)
		update()

func _on_child_entered_tree(node):
	checkNode(node)
func _on_child_exiting_tree(node):
	pass # Replace with function body.


var isHovered = false
func _on_mouse_entered() -> void:
	isHovered = true
func _on_mouse_exited() -> void:
	isHovered = false
