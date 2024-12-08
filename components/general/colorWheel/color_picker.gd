extends Control

@export var color: Color

func _process(delta: float) -> void:	
	var sat = $ratio/hueCircle/inner/sat
	var hue = $ratio/hueCircle.hue
	$ratio/hueCircle/inner/sat.material.set_shader_parameter("hue", hue)
	color = Color.from_hsv(hue, sat.satXYValue.x, 1.0 - sat.satXYValue.y, 1.0)


func _on_scroller_mouse_entered() -> void:
	pass # Replace with function body.
