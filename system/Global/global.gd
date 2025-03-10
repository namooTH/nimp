extends Node

var cameraPosition: Vector2 = Vector2.ZERO
var currentCamera: Camera2D
var currentSpace: Node2D 
var currentColor: Color = Color.from_hsv(0.1, 0.0, 0.0, 1.0)
var screenManager: ScreenManager
signal cameraMoved

signal currentSelectedScreenChanged(selection: ThumbnailBox)
var currentSelectedScreen: ThumbnailBox:
	set(value):
		currentSelectedScreen = value
		currentSelectedScreenChanged.emit(value)
