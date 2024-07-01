extends Control
class_name EndScreen

@export var player : RhythmPlayer
@onready var label = $Label
@onready var label_back = $LabelBack
@onready var timer = $Timer

var is_finished := false


func _ready():
	player.finished.connect(show_text)


func _process(delta):
	if !is_finished:
		return
	if Input.is_action_just_pressed("ui_accept"):
		change_scene()


func show_text():
	label.text = str(GlobalEvents.correct_notes, " из ", GlobalEvents.total_notes)
	label.visible = true
	timer.start()
	await timer.timeout
	label_back.visible = true
	is_finished = true


func change_scene():
	is_finished = false
	SceneTransition.close_screen()
	await SceneTransition.transition_halfway
	SceneTransition.open_screen()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
