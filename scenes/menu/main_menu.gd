extends CanvasLayer
class_name MainMenu

var options_scene = preload("res://scenes/menu/options_menu.tscn")
@onready var margin_container = $MarginContainer
@onready var color_rect = $ColorRect

func _ready():
	%PlayButton.pressed.connect(on_play_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)
	

func on_play_pressed():
	SceneTransition.close_screen()
	await SceneTransition.transition_halfway
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
	SceneTransition.open_screen()


func on_options_pressed():
	SceneTransition.close_screen()
	await SceneTransition.transition_halfway
	var options_instance = options_scene.instantiate() as OptionsMenu
	add_child(options_instance)
	color_rect.visible = false
	margin_container.visible = false
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))
	SceneTransition.open_screen()


func on_quit_pressed():
	get_tree().quit()

func on_options_closed(options_instance: Node):
	color_rect.visible = true
	margin_container.visible = true
	options_instance.queue_free()
