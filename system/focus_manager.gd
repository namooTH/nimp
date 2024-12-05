extends Node

func donothing(): pass
var _currentFocus: Node = null
var _currentFocusCallback: Callable = Callable(self, "donothing")
# for some reason it wont let me put null on it
func handleFocus(node: Node, callback: Callable):
	if node == _currentFocus: return
	unfocusCurrent()
	_currentFocus = node
	_currentFocusCallback = callback
func getFocusNode() -> Node: return _currentFocus
func unfocusCurrent(): if is_instance_valid(_currentFocus):
	_currentFocus = null
	_currentFocusCallback.call()
