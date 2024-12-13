extends Panel

signal done(resolution: Vector2)
func _on_ok_pressed() -> void:
	var x: float = float($width.text)
	var y: float = float($height.text)
	if x != 0 and y != 0: done.emit(Vector2(x,y))
