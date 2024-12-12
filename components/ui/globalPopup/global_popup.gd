extends CanvasLayer

func _ready() -> void:
	showPopup($Control)
	await get_tree().create_timer(3).timeout
	hidePopup()
	

var transparency: float = 0
var transparencyTo: float = 0
func hidePopup():
	transparencyTo = 0
func showPopup(content: Control):
	if content.has_user_signal("choiceDecided"):
		content.reparent($main/main/MarginContainer/Control/content)
		transparencyTo = 1
	
func _process(delta: float) -> void:
	transparency = lerp(transparency, transparencyTo, delta * 8) 
	$main/bars.modulate.a = transparency
	$main/main.modulate.a = transparency * 4
	$main/main.size = $main/anchorTextbox.size * transparency
	$main/main.position = ( ($main/anchorTextbox.position) + ($main/anchorTextbox.size - $main/main.size) / 2 )
	if visible and transparency <= 0.001:
		$main/main/MarginContainer/Control/content.get_children()[0].queue_free()
		hide()
	else: show()
	#var posOffset = (-(transparency - 1)) + $main/main.position
	#$main/main.position = posOffset + ( (-$main/anchorTextbox.size / 2) * (transparency - 1) )
	
