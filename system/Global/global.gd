extends Node

var currentZoomLevel = Vector2.ONE
var cameraPosition: Vector2 = Vector2.ZERO
var currentSpace: Node2D 
var currentColor: Color = Color.from_hsv(0.1, 0.0, 0.0, 1.0)
var screenManager: ScreenManager
signal cameraMoved

signal currentSelectedScreenChanged(selection: ThumbnailBox)
var currentSelectedScreen: ThumbnailBox:
	set(value):
		currentSelectedScreen = value
		currentSelectedScreenChanged.emit(value)
