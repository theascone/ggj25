class_name Player
extends Node2D

@export var min_split_surface = 1
@export var acceleration = 600.0
@export var controlled: Bubble

@export var bubble_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if controlled != null:
		var vel = direction * acceleration * delta
		controlled.add_velocity(vel)

func enumerate_bubbles():
	
	var bubbles = []
	for child in get_node("/root/Root").get_children():
		if child is Bubble:
			bubbles.append(child)
	var sort = func (a: Node2D, b: Node2D):
		return a.position.x < b.position.x
	bubbles.sort_custom(sort)
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
		if controlled.surface < min_split_surface:
			return
		var bubble: Bubble = bubble_scene.instantiate()
		var velocity = controlled.velocity
		var place_dir = Vector2(1, 0)
		if velocity.length() > 1e-5:
			place_dir = velocity.normalized()
		
		bubble.surface = controlled.surface
		controlled.update_surface(0.5)
		bubble.update_surface(0.5)
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

func handle_popped(bubble: Bubble) -> void:
	print("handle_popped")
	var bubbles = enumerate_bubbles()
	if bubbles.size() == 1:
		print("game over")
		var scene = preload("res://scenes/game_over.tscn")
		var instance = scene.instantiate()
		get_node("/root/Root/Camera2D").add_child(instance)
		#get_tree().change_scene_to_file("res://scenes/game_over.tscn")
		#OS.delay_msec(2000)
		#get_tree().change_scene_to_file("res://scenes/menu.tscn")
		controlled = null
		return
	var idx = index_of_bubble(bubbles, controlled)
	idx -= 1
	if idx < 0:
		idx = bubbles.size() - 1
	controlled = bubbles[idx]
