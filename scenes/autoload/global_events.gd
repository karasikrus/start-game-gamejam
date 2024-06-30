extends Node

signal beat(position)
signal measure(position)


func emit_beat(position):
	beat.emit(position)


func emit_measure(position):
	measure.emit(position)
