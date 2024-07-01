extends CharacterBody2D
class_name PLayer

@export var base_line : Line

@onready var arrow_up = %ArrowUp
@onready var arrow_down = %ArrowDown
@onready var no_input_timer = %NoInputTimer
@onready var help_timer = %HelpTimer
@onready var animation_player = $AnimationPlayer


var current_note : int = 5
var max_note_num : int = 9

var is_help_shown := false

func _ready():
	max_note_num = base_line.get_notes_count() - 1
	move_to_note(current_note)
	GlobalEvents.combo.connect(combo_check)

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		move_down()
		input_pressed()
	elif Input.is_action_just_pressed("ui_up"):
		move_up()
		input_pressed()
	
	animate_arrows()


func move_up():
	current_note = clamp(current_note - 1, 0, max_note_num)
	move_to_note(current_note)


func move_down():
	current_note = clamp(current_note + 1, 0, max_note_num)
	move_to_note(current_note)


func move_to_note(note_number : int):
	global_position = base_line.get_note_position(note_number)


func input_pressed():
	no_input_timer.stop()
	if is_help_shown:
		if help_timer.time_left > 0:
			return
		help_timer.start()
		return
	else:
		no_input_timer.stop()


func _on_no_input_timer_timeout():
	is_help_shown = true


func _on_help_timer_timeout():
	is_help_shown = false
	#no_input_timer.start()


func animate_arrows():
	if !is_help_shown:
		arrow_up.visible = false
		arrow_down.visible = false
		return
	arrow_up.visible = current_note > 0
	arrow_down.visible = current_note < max_note_num


func combo_check(combo_num):
	if combo_num == 0:
		animation_player.play("idle")
	elif combo_num == 5:
		animation_player.play("combo")
