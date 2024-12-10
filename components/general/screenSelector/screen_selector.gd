extends Control

func _ready() -> void:
	addCompositon()

var compositions: Array = []
func addCompositon():
	var box = createTB()
	$Scroller.insertNode(box)
	compositions.append(box)
	
func createTB() -> Control:
	var box = $ThumbnailBox.duplicate()
	box.show()
	return box
