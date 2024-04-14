class_name Destinations
extends CanvasGroup

var dummies: Array[DummyPrompt] = []

@onready var anim: AnimationPlayer = $Animator

func _ready() -> void:
	for i in range(get_child_count()):
		var c = get_child(i)
		if not (c is DummyPrompt):
			continue
		dummies.push_back(c)

func appear() -> void:
	anim.play(&"appear")

func bounce(index: int) -> void:
	dummies[index].bounce()
