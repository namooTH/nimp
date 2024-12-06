extends Camera2D

func _process(delta: float) -> void:
	lastMousePos = get_global_mouse_position()
	zoom = lerp(zoom, zoom_to, 10 * delta)
	Global.currentZoomLevel = zoom

var lastMousePos = null
var allowToPan = false
@onready var zoom_to := zoom

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if lastMousePos and allowToPan:
			position += lastMousePos - get_global_mouse_position()
			
	if event.is_action_pressed("mbr"):
		allowToPan = true
	if event.is_action_released("mbr"):
		allowToPan = false
	
	lastMousePos = get_global_mouse_position()
	var scroll := Input.get_axis("scroll_down", "scroll_up")
	zoom_to = clamp(zoom_to + Vector2(scroll, scroll) * 0.05, Vector2(0.001, 0.001), Vector2(10,10))
	#position += zoom_to
