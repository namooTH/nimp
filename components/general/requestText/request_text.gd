extends Control
const title: String = "Text"
var label = Label.new()

signal done(label: Label)
func _on_submit_pressed() -> void:
	done.emit(label)
func setText(text: String) -> void:
	label.text = text
