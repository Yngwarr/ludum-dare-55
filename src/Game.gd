extends Node3D

## The game node, the beginning of all, the almighty entry point, the place,
## where your dreams come true! Adjust to your likings and may the code be with
## you.

@export var pause_ctl: Pause
@export var pause_menu: PauseMenu
@export var progress: PatienceBar

var patience := 50
var is_over := false

@onready var melody_ctl: MelodyController = $MelodyController
@onready var anim: AnimationPlayer = $Animator

func _ready() -> void:
	pause_menu.modal_open.connect(pause_ctl.drop_next)
	pause_menu.resume_pressed.connect(pause_ctl.unpause)

	melody_ctl.prompt_caught.connect(on_prompt_caught)
	melody_ctl.prompt_missed.connect(on_prompt_missed)
	melody_ctl.started_playing.connect(start_sequence)

func on_prompt_caught() -> void:
	if is_over: return

	patience += 5
	progress.set_patience(patience)

func on_prompt_missed() -> void:
	if is_over: return

	patience -= 3
	progress.set_patience(patience)
	if patience <= 0:
		is_over = true
		game_over_seq()

func start_sequence() -> void:
	anim.play(&"start")

func game_over_seq() -> void:
	anim.play(&"game_over")
	melody_ctl.game_over()
