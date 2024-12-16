extends Control
const title: String = "Text"

signal done(string: String)
func _on_submit_pressed() -> void:
	done.emit($edit.text)
func setText(text: String) -> void:
	$edit.text = text
