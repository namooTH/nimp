extends Node

var currentZoomLevel = Vector2.ONE
var cameraPosition: Vector2 = Vector2.ZERO
var currentSpace: Node2D = null
var currentColor: Color = Color.from_hsv(0.1, 0.0, 0.0, 1.0)
signal cameraMoved
