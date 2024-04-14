class_name MelodyController
extends Node

@export var spawn_points: Array[Node2D]
@export var prompt_container: Control
@export var prompt_scene: PackedScene
@export_file("*.json") var song_path: String
@export var spawn_marker: Node2D
@export var catch_marker: Node2D

@onready var music: AudioStreamPlayer = $Music

var prompt_speed := 300
var start_delay: float

var running := false
var music_playing := false
var progress: float = -3.0
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
		music.play()

	if cursor >= len(notes):
		return

	if progress < notes[cursor]["time"] - start_delay:
		return

	spawn_prompt(note_to_prompt(notes[cursor]["name"]))
	cursor += 1

func note_to_prompt(note_name: String):
	match note_name:
		"D3": return 0
		"G3": return 1
		"F3": return 2
		_: return 3

func prepare_song(path: String) -> Variant:
	var file := FileAccess.open(path, FileAccess.READ)
	var content := file.get_as_text()
	var json = JSON.parse_string(content)

	return json["tracks"][0]["notes"]

func play() -> void:
	running = true

func spawn_prompt(idx: int) -> void:
	var prompt = prompt_scene.instantiate()

	prompt.pixels_per_second = prompt_speed
	prompt.position = spawn_points[idx].position

	prompt_container.add_child(prompt)
	prompt.set_direction(idx)
