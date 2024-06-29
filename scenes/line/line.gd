extends Node2D
class_name Line

@onready var notes = $Notes as Node2D
var notes_array : Array[Node2D] = []


func _ready():
	for node in notes.get_children():
		notes_array.push_back(node as Node2D)


func get_note_position(number: int) -> Vector2:
	assert(number >= 0 and number < notes_array.size(), "note outside of notes array")
	return notes_array[number].global_position


func get_notes_count() -> int:
	return notes_array.size()
