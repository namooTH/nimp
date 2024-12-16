extends Node2D

@onready var screen: Control = $ScreenManager

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("copy"):
		var image = await getScreenImage()
		image.save_png(OS.get_system_dir(OS.SYSTEM_DIR_PICTURES) + "/" + "image.png")
	

func _ready() -> void:
	$Camera.position = $ScreenManager.size / 2
	Global.currentSpace = self

func _process(delta: float) -> void:
	$bg.size = screen.size
	$bg.position = screen.position

func getScreenImage() -> Image:
	var render = $Render
	var camera = $"Render/2dSpace/Camera"
	
	$"placeholder-msg".size = screen.size
	$"placeholder-msg".show()
	
	render.size = screen.size
	camera.position = Vector2.ZERO
	
	if is_instance_valid(SelectionManager.getSelectedNode()):
		var selectedEntireSize = SelectionManager.getSelectedNode().position + SelectionManager.getSelectedNode().size
		var renderSizeClipped = selectedEntireSize - screen.size
		# only take action for the **vaild** non negative value
		render.size.x = SelectionManager.getSelectedNode().size.x - max(renderSizeClipped.x, 0.0)
		render.size.y = SelectionManager.getSelectedNode().size.y - max(renderSizeClipped.y, 0.0)
		camera.position = SelectionManager.getSelectedNode().position
		# take action for the **vaild** negatives value
		if camera.position.x < 0:
			render.size.x -= abs(camera.position.x)
			camera.position.x = 0
		if camera.position.y < 0:
			render.size.y -= abs(camera.position.y)
			camera.position.y = 0
		
	
	screen.reparent($"Render/2dSpace")
	render.render_target_update_mode = SubViewport.UPDATE_ONCE
	await RenderingServer.frame_post_draw
	var image = render.get_texture().get_image()
	
	screen.reparent(self)
	$"placeholder-msg".hide()
	return image
