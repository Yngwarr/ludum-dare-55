class_name MelodyController
extends Node

signal prompt_caught(index: int)
signal prompt_missed
signal started_playing
signal start_dancing
signal start_raving
signal eternal_roar

@export var spawn_points: Array[Node2D]
@export var prompt_container: CanvasLayer
@export var prompt_scene: PackedScene
@export_file("*.json") var song_path: String
@export var spawn_marker: Node2D
@export var catch_marker: Node2D

@onready var music: AudioStreamPlayer = $Music

var prompt_speed := 300
var start_delay: float

var running := false
var music_playing := false
var progress: float = -1.0
var cursor: int = 0
var notes

func _ready() -> void:
	notes = prepare_song(song_path)
	start_delay = abs(spawn_marker.position.y - catch_marker.position.y) / prompt_speed

	play()

func _physics_process(delta: float) -> void:
	if !running:
		return

	progress += delta

	if !music_playing and progress >= 0:
		music_playing = true
		started_playing.emit()
		music.play()

	process_note()
	process_event()

func process_note() -> void:
	if cursor >= len(notes):
		return

	if progress < notes[cursor]["time"] - start_delay:
		return

	var prompt = note_to_prompt(notes[cursor]["name"])
	if prompt == -1:
		return

	spawn_prompt(prompt)
	cursor += 1

func process_event() -> void:
	if cursor >= len(notes):
		return

	if progress < notes[cursor]["time"]:
		return

	match notes[cursor]["name"]:
		"C3": start_dancing.emit()
		"D3": start_raving.emit()
		"E3": eternal_roar.emit()
		_: return

	cursor += 1

func cast_event(note: String) -> void:
	match note:
		"C3": start_dancing.emit()
		"D3": start_raving.emit()
		"E3": eternal_roar.emit()

func note_to_prompt(note_name: String):
	match note_name:
		"C4": return 0
		"D4": return 1
		"E4": return 2
		"F4": return 3
	return -1

func prepare_song(path: String) -> Variant:
	var file := FileAccess.open(path, FileAccess.READ)
	var content := file.get_as_text()
	var json = JSON.parse_string(content)

	return json["tracks"][0]["notes"]

func play() -> void:
	running = true

func spawn_prompt(idx: int) -> void:
	var prompt = prompt_scene.instantiate()

	prompt.caught.connect(on_prompt_caught)
	prompt.missed.connect(on_prompt_missed)

	prompt.pixels_per_second = prompt_speed
	prompt.position = spawn_points[idx].position

	prompt_container.add_child(prompt)
	prompt.set_direction(idx)

func on_prompt_caught(index: int) -> void:
	prompt_caught.emit(index)

func on_prompt_missed() -> void:
	prompt_missed.emit()

func game_over() -> void:
	running = false
	drop_prompts()

func drop_prompts() -> void:
	for i in range(prompt_container.get_child_count()):
		var c = prompt_container.get_child(i)
		if not (c is Prompt):
			continue
		c.drop()
