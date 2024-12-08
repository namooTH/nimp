@tool
class_name AutoSizeLabel extends Label

@export var max_font_size = 56


func _ready() -> void:
	clip_text = true
	item_rect_changed.connect(_on_item_rect_changed)


func _set(property: StringName, value: Variant) -> bool:
	match property:
		"text":
			if value != text:
				update_font_size(value)
	return false


func update_font_size(new_text: String) -> void:
	var font := get_theme_font("font")
	var font_size := get_theme_font_size("font_size")
	var suitable_font_size: int = -1

	var line := TextLine.new()
	line.direction = text_direction as TextServer.Direction
	line.flags = justification_flags
	line.alignment = horizontal_alignment

	for i in max_font_size:
		line.clear()
		var created := line.add_string(new_text, font, font_size)
		if created:
			var text_size := line.get_line_width()

			if text_size > floor(size.x):
				if suitable_font_size > 0:
					font_size = suitable_font_size
					break
				if font_size == 1:
					break
				font_size -= 1
			elif font_size < max_font_size:
				suitable_font_size = font_size
				font_size += 1
			else:
				break
		else:
			push_warning("Could not create a string")
			break

	add_theme_font_size_override("font_size", font_size)


func _on_item_rect_changed() -> void:
	update_font_size(text)
