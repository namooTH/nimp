extends Panel
class_name ThumbnailBox

@export var title: String
@export var type: String
@export var node: Node

func setType(_type: String):
	$margin/content/type.text = _type
	type = _type
func setTitle(_title: String):
	$margin/content/title.text = _title
	title = _title
func setNode(_node: Node):
	node = _node
	
func _on_click_area_pressed() -> void:
	Global.currentSelectedScreen = self
