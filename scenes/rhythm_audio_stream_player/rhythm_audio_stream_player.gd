extends AudioStreamPlayer
class_name RhythmPlayer

@export var bpm := 100
@export var measures := 4

@export var notes_data : Array[NoteData]

@export var note_track : NoteTrack
@export var moving_time : float = 1

var next_note_index := 0

var song_position := 0.0
var song_position_in_beats = 1
var sec_per_beat : float
var last_reported_beat = 0
var measure = 1
 
var tween : Tween

func _ready():
	sec_per_beat = 60.0 / bpm
	GlobalEvents.beat.connect(on_beat)
	moving_time = sec_per_beat * 16
	GlobalEvents.restart_combo()
	GlobalEvents.combo.connect(combo_check)


func _physics_process(delta):
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_position_in_beats = int(floor(song_position / sec_per_beat))
		update_beat()


func update_beat():
	if last_reported_beat >= song_position_in_beats:
		return
	if measure > measures:
		measure = 1
	GlobalEvents.emit_beat(song_position_in_beats)
	GlobalEvents.emit_measure(measure)
	last_reported_beat = song_position_in_beats
	prints("beat", last_reported_beat, "measure", measure)
	measure += 1


func on_beat(beat_number : int):
	if next_note_index == notes_data.size():
		return
	var note_data : NoteData = notes_data[next_note_index]
	if note_data.beat != beat_number:
		return
	next_note_index += 1
	prints(note_data.note_position, note_data.visibility)
	note_track.spawn_moving_line(note_data.note_position, note_data.visibility, moving_time)


func _on_finished():
	pass # Replace with function body.


func combo_check(combo_num):
	if combo_num == 0:
		increase_sound()
	elif combo_num == 5:
		decrease_sound()
		
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
