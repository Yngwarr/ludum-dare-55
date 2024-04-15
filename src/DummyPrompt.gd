class_name DummyPrompt
extends Node2D

@onready var anim: AnimationPlayer = $Animator

func bounce() -> void:
    anim.stop()
    anim.play(&"blow")
