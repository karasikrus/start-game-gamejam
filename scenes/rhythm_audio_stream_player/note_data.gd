extends Resource
class_name NoteData

@export var beat : int
@export var note_position : int
@export var visibility : NoteVisibility

enum NoteVisibility {
	SHOWN,
	HALF_SHOWN,
	HIDDEN
}
