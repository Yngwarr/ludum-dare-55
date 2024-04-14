class_name GameOverScreen
extends CanvasLayer

@export var pause: Pause

func appear() -> void:
	get_tree().paused = true
	show()
