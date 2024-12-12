extends Control
class_name Composition

var selectableContainer = preload("res://components/general/selection/selectable_container/selectableContainer.tscn")

func _input(event: InputEvent) -> void:
	if !get_parent().visible: return
	if event.is_action_pressed("paste"):
		if DisplayServer.clipboard_has_image(): makeTextureFromImage(DisplayServer.clipboard_get_image())
		
func makeTextureFromImage(image: Image):
	var imageNode: TextureRect = TextureRect.new()
	imageNode.texture = ImageTexture.create_from_image(image)
	imageNode.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	imageNode.set_anchors_preset(Control.PRESET_FULL_RECT)
	var container = makeContainer()
	container.size = imageNode.texture.get_size()
	container.add_child(imageNode)

func makeContainer() -> Node:
	var container = selectableContainer.instantiate()
	add_child(container)
	return container
