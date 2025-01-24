class_name Player
extends Node2D

@export var acceleration = 600.0
@export var controlled: Bubble

@export var bubble_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	controlled.add_velocity(direction * acceleration * delta)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("split"):
		var bubble: Bubble = bubble_scene.instantiate()
		var velocity = controlled.velocity
		var place_dir = Vector2(1, 0)
		if velocity.length() > 1e-5:
			place_dir = velocity.normalized()
			
		bubble.position = controlled.position - place_dir
		controlled.position += place_dir
		
		get_node("/root/Root").add_child(bubble)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
