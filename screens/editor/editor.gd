extends Node2D

var selectableContainer = preload("res://components/general/selection/selectable_container/selectableContainer.tscn")

func _ready() -> void:
	$Camera.position = $Canvas.size / 2
	Global.currentSpace = self

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("paste"):
		if DisplayServer.clipboard_has_image(): makeTextureFromImage(DisplayServer.clipboard_get_image())
	if event.is_action_released("copy"):
		var image = await getCanvasImage()
		image.save_png(OS.get_system_dir(OS.SYSTEM_DIR_PICTURES) + "/" + "image.png")
	
func getCanvasImage() -> Image:
	var canvas = $Canvas
	var render = $Render
	render.size = canvas.size
	canvas.reparent($"Render/2dSpace")
	canvas.get_node("bg").hide()
	render.render_target_update_mode = SubViewport.UPDATE_ONCE
	await RenderingServer.frame_post_draw
	var image = render.get_texture().get_image()
	canvas.get_node("bg").show()
	canvas.reparent(self)
	return image

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
	$Canvas.add_child(container)
	return container
