class_name Prompt
extends Node2D

var pixels_per_second := 200

func _ready() -> void:
    add_to_group(&"prompt")

func _process(delta: float) -> void:
    if !visible:
        return

    translate(Vector2.UP * delta * pixels_per_second)
