extends Node2D
class_name Note

signal processed()
signal dead()

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

@export var half_shown_time : float = 1


var is_processed := false

func set_note_visibility(state: NoteData.NoteVisibility):
	if state == NoteData.NoteVisibility.SHOWN:
		visible = true
	if state == NoteData.NoteVisibility.HALF_SHOWN:
		var tween = get_tree().create_tween()
		tween.tween_property(sprite_2d, "modulate", Color("ffffff00"), half_shown_time)
	if state == NoteData.NoteVisibility.HIDDEN:
		visible = false


func _on_correct_area_2d_area_entered(area):
	if is_processed:
		return
	is_processed = true
	GlobalEvents.correct_note()
	animation_player.play("correct")
	processed.emit()
	await animation_player.animation_finished
	dead.emit()


func _on_wrong_area_2d_area_entered(area):
	if is_processed:
		return
	is_processed = true
	GlobalEvents.wrong_note()
	animation_player.play("wrong")
	processed.emit()
	await animation_player.animation_finished
	dead.emit()
