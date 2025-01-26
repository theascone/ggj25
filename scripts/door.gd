extends StaticBody2D

@onready var audio_door_close: AudioStreamPlayer = $Audio_Door_close
@onready var audio_door_open: AudioStreamPlayer = $Audio_Door_open


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func change_state(state):
	$CollisionShape2D.set_deferred("disabled", state)
	$Polygon2D.visible = !state
	if state:
		if audio_door_open != null:
			audio_door_open.play()
	else:
		if audio_door_close != null:
			audio_door_close.play()
