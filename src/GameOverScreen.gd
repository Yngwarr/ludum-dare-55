class_name GameOverScreen
extends CanvasLayer

@export var focused_button: Button

func appear() -> void:
	get_tree().paused = true
	show()
	focused_button.grab_focus()
