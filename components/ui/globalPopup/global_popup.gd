extends CanvasLayer

func _ready() -> void:
	showPopup()

var transparency: float = 0
func hidePopup():
	transparency = 0
func showPopup():
	transparency = 1
func _process(delta: float) -> void:
	$main/bars.modulate.a = lerp($main/bars.modulate.a, transparency, delta * 5)
