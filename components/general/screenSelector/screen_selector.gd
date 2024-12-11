extends Control

var compositions: Array = []
var references: Array = []
var edits: Array = []
func _ready() -> void:
	references.append(addReference())
	edits.append(addEdit(references[0]))
	edits.append(addEdit(references[0]))
	compositions.append(addCompositon())
	
func addCompositon():
	var box = createTB()
	box.setType("composition")
	$Scroller.insertNode(box)
	return box
func addReference():
	var box = createTB()
	box.setType("reference")
	$Scroller.insertNode(box)
	return box
func addEdit(reference: Control):
	var box = createListedTB()
	box.get_node("ThumbnailBox").setType("edit")
	var index = $Scroller.findIndex(reference)
	if index+1 <= 0: return
	$Scroller.insertNode(box, index+1)
	return box
	
func createTB() -> Control:
	var box = $ThumbnailBox.duplicate()
	box.show()
	return box
func createListedTB() -> Control:
	var box = $ListedThumbnailBox.duplicate()
	box.show()
	return box
