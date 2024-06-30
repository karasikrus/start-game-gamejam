extends Node2D
class_name NoteTrack

@onready var water_sprite_2d = $WaterSprite2D

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
