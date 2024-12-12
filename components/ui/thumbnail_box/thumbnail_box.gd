extends Panel
class_name ThumbnailBox

@export var title: String
@export var type: String

func setType(_type: String):
	$margin/content/type.text = _type
	type = _type
func setTitle(_title: String):
	$margin/content/title.text = _title
	title = _title
func _on_click_area_pressed() -> void:
	Global.currentSelectedScreen = self
