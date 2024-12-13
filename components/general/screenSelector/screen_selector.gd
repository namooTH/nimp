extends Control

var compositions: Array = []
var references: Array = []
var edits: Array = []

func _ready() -> void:
	Global.currentSelectedScreenChanged.connect(updateOptionButton)

func addCompositon():
	var box = createTB()
	box.setType("composition")
	box.node = await Global.screenManager.makeCompositionScreen()
	$Scroller.insertNode(box)
	return box
func addReference():
	var box = createTB()
	box.setType("reference")
	box.node = await Global.screenManager.makeReference()
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
	
func updateOptionButton(selection: ThumbnailBox) -> void:
	match selection.type:
		"reference":
			$topPanel/margin/control/OptionButton.clear()
			$topPanel/margin/control/OptionButton.add_item("edit")
		"edit":
			$topPanel/margin/control/OptionButton.clear()
		_:
			$topPanel/margin/control/OptionButton.clear()
			$topPanel/margin/control/OptionButton.add_item("composition")
			$topPanel/margin/control/OptionButton.add_item("reference")

func _on_button_pressed() -> void:
	match $topPanel/margin/control/OptionButton.get_item_text($topPanel/margin/control/OptionButton.selected):
		"composition":
			await addCompositon()
		"reference":
			await addReference()
		"edit":
			await addEdit(Global.currentSelectedScreen)
