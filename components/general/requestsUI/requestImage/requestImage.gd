extends Panel
const title: String = "Image"

signal done(imageTexture: ImageTexture)
func _on_clickarea_pressed() -> void:
	$FileDialog.show()
func _on_file_dialog_file_selected(path: String) -> void:
	var image = Image.load_from_file(path)
	done.emit(ImageTexture.create_from_image(image))
