class_name PatienceBar
extends TextureProgressBar

@export var happy_face: Texture2D
@export var neutral_face: Texture2D
@export var sad_face: Texture2D

@onready var face: TextureRect = $Face

var tween: Tween

func set_patience(new_value: int) -> void:
	if new_value < 33:
		face.texture = sad_face
	elif new_value < 66:
		face.texture = neutral_face
	else:
		face.texture = happy_face
	value = new_value
