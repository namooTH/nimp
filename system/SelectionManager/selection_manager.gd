extends Node

var _currentSelection: Control = null
signal selectionRequiresHandle(node: Control)

func requiresSelection(node: Control):
	if node == _currentSelection: return
	_currentSelection = node
	selectionRequiresHandle.emit(_currentSelection)
func deselectCurrentSelection(): _currentSelection = null
func getSelectedNode() -> Node: return _currentSelection
