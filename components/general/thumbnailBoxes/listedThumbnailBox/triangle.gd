extends Control

func _on_resized() -> void:
	$polygon.polygon[0].x = 2
	$polygon.polygon[0].y = size.y - 2
	$polygon.polygon[1].x = size.x - 2
	$polygon.polygon[1].y = size.y / 2
	$polygon.polygon[2].x = 2
	$polygon.polygon[2].y = 2
