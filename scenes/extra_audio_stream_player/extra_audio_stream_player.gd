extends AudioStreamPlayer
class_name ExtraAudioPlayer

var tween : Tween

func _ready():
	GlobalEvents.combo.connect(combo_check)


func combo_check(combo_num):
	if combo_num == 0:
		decrease_sound()
	elif combo_num == 5:
		increase_sound()
		
func decrease_sound():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(self, "volume_db", -80, 0)

func increase_sound():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(self, "volume_db", 0, 0)
