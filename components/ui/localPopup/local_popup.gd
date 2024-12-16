extends CanvasLayer

var transparency: float = 0
var transparencyTo: float = 0
func hidePopup():
	transparencyTo = 0
func showPopup(content: Control, at: Control):
	if content.has_signal("done"):
		if "title" in content:
			$base/margin/main/title.text = content.title
		
		$base.size = Vector2(400, 300)
		$base.position = at.get_global_transform_with_canvas().get_origin() + (at.size * Global.currentCamera.zoom) / 1.5
		
		var sizeClipped = ($base.position + $base.size) - Vector2(get_viewport().size)
		# only take action for the **vaild** non negative value
		$base.size.x -= max(sizeClipped.x, 0.0)
		$base.size.y -= max(sizeClipped.y, 0.0)
		
		content.reparent($base/margin/main/content)
		content.position = Vector2.ZERO
		transparencyTo = 1
		var data = await content.done
		transparencyTo = 0
		return data
	return
	
func _process(delta: float) -> void:
	transparency = lerp(transparency, transparencyTo, delta * 8) 
	$base.modulate.a = transparency
	#$main/main.size = $main/anchorTextbox.size * transparency
	#$main/main.position = ( ($main/anchorTextbox.position) + ($main/anchorTextbox.size - $main/main.size) / 2 )
	if transparencyTo == 0 and transparency <= 0.001:
		var content = $base/margin/main/content
		if content.get_children(): content.get_child(0).queue_free()
		hide()
	else: show()
