class_name Destinations
extends CanvasGroup

@onready var anim: AnimationPlayer = $Animator

func appear() -> void:
    anim.play(&"appear")
