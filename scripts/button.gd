extends Node2D

@export var min_surface = 1
@export var shape: Shape2D

@onready var audio_button_press: AudioStreamPlayer = $Audio_Button_Press
@onready var audio_button_release: AudioStreamPlayer = $Audio_Button_Release

signal status_change(status)

var active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Polygon2D.color = Color(200, 0, 0)
	status_change.emit(active)



func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.collision_mask = 1
	query.transform = transform
	var results = space_state.intersect_shape(query)
	var should_activate = false
	for result in results:
		var bubble := result["collider"] as Bubble
		if bubble != null and bubble.surface >= min_surface:
			should_activate = true
	if should_activate != active:
		active = should_activate
		status_change.emit(active)
		if active:
			audio_button_press.play()
			$Polygon2D.color = Color(0, 200, 0)
		else:
			audio_button_release.play()
			$Polygon2D.color = Color(200, 0, 0)
