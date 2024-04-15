class_name Wizard
extends Node3D

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
    anim.play(&"Idle")

func ritual() -> void:
    anim.play(&"Idle2Ritual")
    anim.queue(&"Ritual")

func faster_ritual() -> void:
    anim.play(&"Ritual", -1, 2)

func ferocious_ritual() -> void:
    anim.play(&"Ritual", -1, 3)

func cast_wrath() -> void:
    anim.play(&"Summoning")

func enough() -> void:
    anim.play(&"Ritual2Idle")

func victory() -> void:
    anim.play(&"Idle2Win")
    anim.queue(&"Win")
