class_name Prompt
extends Node2D

func _ready() -> void:
    pass

func _process(delta: float) -> void:
    if !visible:
        return

    translate(Vector2.UP * delta * 200)
