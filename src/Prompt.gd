class_name Prompt
extends Node2D

signal caught(index: int)
signal missed

const LEFT := 0
const DOWN := 1
const UP := 2
const RIGHT := 3

@export var arrow_textures: Array[Texture2D]

var pixels_per_second := 200
var action: StringName
var direction := 0
var catchable := false
var dropping := false

@onready var area: Area2D = $Area2D
@onready var view: Sprite2D = $View
@onready var anim: AnimationPlayer = $Animator

func _ready() -> void:
	add_to_group(&"prompt")
	area.area_entered.connect(on_area_entered)
	area.area_exited.connect(on_area_exited)

func _process(delta: float) -> void:
	if !visible: return
	if dropping: return

	translate(Vector2.UP * delta * pixels_per_second)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(action):
		if !catchable:
			return

		disappear()

func on_area_entered(other: Area2D) -> void:
	if dropping: return
	if other.is_in_group(&"catcher"):
		catchable = true
		# modulate = Color.GREEN

func on_area_exited(other: Area2D) -> void:
	if dropping: return
	if other.is_in_group(&"catcher"):
		catchable = false
		# modulate = Color.RED
		missed.emit()
		queue_free()

func disappear() -> void:
	caught.emit(direction)
	queue_free()

func set_direction(new_direction: int) -> void:
	direction = new_direction
	view.texture = arrow_textures[direction]

	match direction:
		LEFT:
			action = &"game_left"
		RIGHT:
			action = &"game_right"
		DOWN:
			action = &"game_down"
		UP:
			action = &"game_up"

func drop() -> void:
	dropping = true

	var tween := create_tween()
	tween.tween_property(self, "position", Vector2(position.x + (-200 + randf() * 400), position.y + 1000), .8)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(self, "rotation_degrees", -90 + randf() * 180, .8)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CUBIC)
