class_name Prompt
extends Node2D

func _ready() -> void:
    add_to_group(&"prompt")

func _process(delta: float) -> void:
    if !visible:
        return

    translate(Vector2.UP * delta * 200)
