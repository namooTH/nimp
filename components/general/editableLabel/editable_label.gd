extends Control

var requestText = preload("res://components/general/requestText/requestText.tscn")
func action() -> void:
	var RR = requestText.instantiate()
	add_child(RR)
	RR.setText($MarkdownLabel.markdown_text)
	var label: Label = await LocalPopup.showPopup(RR, self)
	$MarkdownLabel.markdown_text = label.text

func setText(string: String):
	$MarkdownLabel.markdown_text = string
