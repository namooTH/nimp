extends Node

func _ready() -> void:
	var insertAtIndex = -1
	
	var firstarray = []
	var secondarray = []
	var thirdarray = []
	
	var accessIndex: int
	if insertAtIndex < 0: accessIndex = (firstarray.size() + secondarray.size() + thirdarray.size()) + insertAtIndex + 1
	else: accessIndex = insertAtIndex
	
	var totalSize = 0
	for listCount in range(3):
		var workingArray: Array
		match listCount:
			0: workingArray = firstarray
			1: workingArray = secondarray
			2: workingArray = thirdarray
		totalSize += workingArray.size()
		if accessIndex <= totalSize:
			if accessIndex <= firstarray.size(): workingArray.insert(accessIndex, "hello")
			else: workingArray.insert(workingArray.size() - (totalSize - accessIndex), "hello")
			break
