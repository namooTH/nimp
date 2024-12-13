extends Control
class_name ScreenManager

func _ready() -> void:
	Global.connect("currentSelectedScreenChanged", swtichScreenFromThumbnailBox)
	Global.screenManager = self

func swtichScreenFromThumbnailBox(node: ThumbnailBox):
	switchScreen(node.node)

var composition = preload("res://components/general/screens/composition/Composition.tscn")
var requestResolution = preload("res://components/general/requestsUI/requestResolution/requestResolution.tscn")
func makeCompositionScreen(resolution: Vector2 = Vector2.ZERO) -> Composition:
	var screen: Composition = composition.instantiate()
	var RR = requestResolution.instantiate()
	add_child(RR)
	if resolution == Vector2.ZERO: screen.size = await GlobalPopup.showPopup(RR)
	else: screen.size = resolution
	add_child(screen)
	move_child(screen, 1)
	switchScreen(screen)
	return screen

var requestImage = preload("res://components/general/requestsUI/requestFile/requestImage.tscn")
func makeReference(image: ImageTexture = null) -> TextureRect:
	var screen: TextureRect = TextureRect.new()
	var RI = requestImage.instantiate()
	add_child(RI)
	if image == null: screen.texture = await GlobalPopup.showPopup(RI)
	else: screen.texture = image
	screen.size = screen.texture.get_size()
	add_child(screen)
	move_child(screen, 1)
	switchScreen(screen)
	return screen

func switchScreen(screen: Node) -> void:
	if get_child_count() > 1: get_child(-1).reparent(get_child(0))
	screen.reparent(self)
	size = screen.size
