extends Control

@export var scene: PackedScene
@onready var bubble: Bubble = $Bubble

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.grab_focus()

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("split"):
		get_tree().change_scene_to_file("res://scenes/level1.tscn")
		
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
	#get_tree().change_scene_to_packed(scene)

func _on_exit_pressed() -> void:
	get_tree().quit()
