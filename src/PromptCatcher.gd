extends Node2D

@onready var area: Area2D = $Area2D

func _ready() -> void:
	area.add_to_group(&"catcher")
