class_name Cat
extends Node3D

@onready var anim: AnimationPlayer = $AnimationPlayer

var dancing := false

func _ready() -> void:
    anim.play(&"IdleStay")

func prepare() -> void:
    dancing = true
    anim.play(&"IdleStay2DanceIdle")
    anim.queue(&"DanceIdle")

func dance(index: int) -> void:
    if not dancing: return

    var next_move: StringName

    match index:
        0: next_move = &"DanceLeft"
        1: next_move = &"DanceDown"
        2: next_move = &"DanceUp"
        3: next_move = &"DanceRight"

    anim.play(next_move)
    anim.queue(&"DanceIdle")
