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
	
	
	var scroll := Input.get_axis("scroll_down", "scroll_up")
	if scroll <= 0 and zoom_to >= Vector2.ONE:
		zoom_to += Vector2(scroll, scroll) * 0.3
	if scroll >= 0:
		zoom_to += Vector2(scroll, scroll) * 0.3
