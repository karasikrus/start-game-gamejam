extends Node2D
class_name NoteTrack

@onready var water_sprite_2d = $WaterSprite2D

@onready var line_start = $LineStart
@onready var line_start_2 = $LineStart2

@export var moving_line_scene : PackedScene

var dissolve_value = 0
var tween : Tween
var property_path = "material/shader_parameter/dissolve_value"

func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		appear()
	if Input.is_action_just_pressed("ui_right"):
		disapperar()


func appear():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, dissolve_value, 1, 2)


func disapperar():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, dissolve_value, 0, 1)


func set_shader_value(value: float):
	dissolve_value = value
	water_sprite_2d.material.set_shader_parameter("dissolve_value", value);


func spawn_moving_line(note_position : int, note_visibility : int, moving_time : float):
	var moving_line_instance = moving_line_scene.instantiate() as MovingLine
	get_tree().get_first_node_in_group("moving_lines").add_child(moving_line_instance)
	moving_line_instance.global_position = line_start_2.global_position
	moving_line_instance.set_note_position(note_position, note_visibility)
	moving_line_instance.start_moving(moving_time, line_start.global_position)
