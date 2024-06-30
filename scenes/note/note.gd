extends Node2D
class_name Note

@onready var sprite_2d = $Sprite2D

@export var half_shown_time : float = 1



func set_note_visibility(state: NoteData.NoteVisibility):
	if state == NoteData.NoteVisibility.SHOWN:
		visible = true
	if state == NoteData.NoteVisibility.HALF_SHOWN:
		var tween = get_tree().create_tween()
		tween.tween_property(sprite_2d, "modulate", Color("ffffff00"), half_shown_time)
	if state == NoteData.NoteVisibility.HIDDEN:
		visible = false
