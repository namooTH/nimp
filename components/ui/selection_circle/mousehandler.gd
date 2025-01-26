extends Control

@onready var baseSize: Vector2 = size
@onready var currentSize: Vector2 = size
@onready var lastSize = size

func unfocus(): currentSize = baseSize
func focus():
	currentSize = baseSize * 2
	FocusManager.handleFocus(self, unfocus)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mbl") and isMouseHovered:
		focus()

func _physics_process(delta: float) -> void:
	size = lerp(size, currentSize, delta * 5)
	position -= (size - lastSize) / 2
	lastSize = size 

var isMouseHovered = false
func _on_mouse_entered() -> void: isMouseHovered = true
func _on_mouse_exited() -> void: isMouseHovered = false
