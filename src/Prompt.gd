class_name Prompt
extends Node2D

signal caught

const LEFT := 0
const DOWN := 1
const UP := 2
const RIGHT := 3

@export var arrow_textures: Array[Texture2D]

var pixels_per_second := 200
var action: StringName
var catchable := false

@onready var area: Area2D = $Area2D
@onready var view: Sprite2D = $View

func _ready() -> void:
	add_to_group(&"prompt")
	area.area_entered.connect(on_area_entered)
	area.area_exited.connect(on_area_exited)

func _process(delta: float) -> void:
	if !visible:
		return

	translate(Vector2.UP * delta * pixels_per_second)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(action):
		if !catchable:
			return

		disappear()

func on_area_entered(other: Area2D) -> void:
	if other.is_in_group(&"catcher"):
		catchable = true
		modulate = Color.GREEN

func on_area_exited(other: Area2D) -> void:
	if other.is_in_group(&"catcher"):
		catchable = false
		modulate = Color.RED

func disappear() -> void:
	caught.emit()
	queue_free()

func set_direction(direction: int) -> void:
	view.texture=arrow_textures[direction]
	match direction:
		LEFT:
			action = &"game_left"
		RIGHT:
			action = &"game_right"
		DOWN:
			action = &"game_down"
		UP:
			action = &"game_up"
