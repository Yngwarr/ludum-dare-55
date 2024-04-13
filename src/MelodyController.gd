class_name MelodyController
extends Node

@export var spawn_points: Array[Node2D]
@export var prompt_container: Control
@export var prompt_scene: PackedScene

func _ready() -> void:
    for spawn in spawn_points:
        var prompt = prompt_scene.instantiate()
        prompt.position = spawn.position
        prompt_container.add_child(prompt)
