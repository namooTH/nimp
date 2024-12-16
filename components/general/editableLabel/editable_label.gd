extends Control

var requestText = preload("res://components/general/requestText/requestText.tscn")
func action() -> void:
	var RR = requestText.instantiate()
	add_child(RR)
	RR.setText($MarkdownLabel.markdown_text)
	$MarkdownLabel.markdown_text = await LocalPopup.showPopup(RR, self)

func setText(string: String):
	$MarkdownLabel.markdown_text = string
