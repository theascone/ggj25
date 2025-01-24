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

func enumerate_bubbles():
	var bubbles = []
	for child in get_node("/root/Root").get_children():
		if child is Bubble:
			bubbles.append(child)
	return bubbles
	
func index_of_bubble(bubbles, target):
	var i = 0
	for bubble in bubbles:
		if bubble == target:
			return i
		i += 1
	return i
			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("split"):
		var bubble: Bubble = bubble_scene.instantiate()
		var velocity = controlled.velocity
		var place_dir = Vector2(1, 0)
		if velocity.length() > 1e-5:
			place_dir = velocity.normalized()
			
		bubble.position = controlled.position - 2 * place_dir
		controlled.position += 2 * place_dir
		
		get_node("/root/Root").add_child(bubble)
	
	var bubbles = enumerate_bubbles()
	var idx = index_of_bubble(bubbles, controlled)
	if event.is_action_pressed("switch_left"):
		idx -= 1
		if idx < 0:
			idx = bubbles.size() - 1
		controlled = bubbles[idx]

	if event.is_action_pressed("switch_right"):
		idx += 1
		if idx >= bubbles.size():
			idx = 0
		controlled = bubbles[idx]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
