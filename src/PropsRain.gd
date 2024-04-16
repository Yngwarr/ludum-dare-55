class_name PropsRain
extends Node3D

func _ready() -> void:
    off()

func set_amount(ratio: float) -> void:
    for i in get_child_count():
        get_child(i).amount_ratio = ratio

func off() -> void:
    set_amount(0)

func some() -> void:
    set_amount(.5)

func all() -> void:
    set_amount(1)
