class_name MelodyController
extends Node

@export var spawn_points: Array[Node2D]
@export var prompt_container: Control
@export var prompt_scene: PackedScene
@export_file("*.json") var song_path: String

@onready var start_timer: Timer = $StartTimer
@onready var music: AudioStreamPlayer = $Music

var running := false
var progress: float = 0
var cursor: int = 0
var notes

func _ready() -> void:
    notes = prepare_song(song_path)
    start_timer.timeout.connect(play)
    start_timer.start()

func prepare_song(path: String) -> Variant:
    var file := FileAccess.open(path, FileAccess.READ)
    var content := file.get_as_text()
    var json = JSON.parse_string(content)

    return json["tracks"][0]["notes"]

func play() -> void:
    music.play()
    running = true

func _physics_process(delta: float) -> void:
    if !running:
        return

    progress += delta

    if cursor >= len(notes):
        return

    if progress < notes[cursor]["time"]:
        return

    cursor += 1
    spawn_prompt(0)

func spawn_prompt(idx: int) -> void:
    var prompt = prompt_scene.instantiate()
    prompt.position = spawn_points[idx].position
    prompt_container.add_child(prompt)
