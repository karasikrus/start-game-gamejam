extends Node2D
class_name MovingLine

@export var movement_time : float = 5
@export var note_position : int = 0

@onready var notes = $Line/Notes
@onready var note = $Note
var note_positions : Array[Vector2] = []

func _ready():
	for n in notes.get_children():
		note_positions.push_back((n as Node2D).position)

func start_moving(time : float, target : Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target, time)


func set_note_position(number : int, note_visibility : int):
	note_position = number
	note.position = note_positions[note_position]
	note.set_note_visibility(note_visibility)
	