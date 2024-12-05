extends Node

func donothing(): pass
var _currentSelection: Control = null

func handleSelection(node: Control):
	if node == _currentSelection: return
	_currentSelection = node
	TopLevel.get_node("selection").select(node)
func getSelectedNode() -> Node: return _currentSelection
