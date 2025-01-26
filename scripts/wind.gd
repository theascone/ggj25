extends Area2D

@export var gust_scene: PackedScene
@export var direction = Vector2(1, 0)
@export var acceleration = 500.0 
@export var wind_timeout = 3

var active_bubbles = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for node in get_children():
		var shapeo = node as CollisionShape2D
		if shapeo == null:
			continue
		# todo spawn particles

func _physics_process(delta: float) -> void:
	var velocity = direction.normalized() * acceleration * delta
	for bubble in active_bubbles:
		bubble.add_velocity(velocity)

func _on_body_entered(body: Node2D) -> void:
	var bubble := body as Bubble
	if bubble == null:
		return
	active_bubbles.append(bubble)

func _on_body_exited(body: Node2D) -> void:
	var bubble := body as Bubble
	if bubble == null:
		return
	active_bubbles.erase(bubble)

func _on_spawn_timer_timeout() -> void:
	var curve = $Path2D.curve
	
	#var max = 2000
	#var rand = (Time.get_ticks_msec() % max) / float(max)
	
	var start = curve.samplef(0)
	var end = curve.samplef(1)
	
	var width = 300
	var length = (end - start).length()
	
	var repeats = floor(length / width)
	
	var pitch = length / repeats
	
	var offset = pitch / 2
	while offset < length:
		var node = gust_scene.instantiate()
		node.position = lerp(start, end, offset/length) + global_position
		node.speed = direction * acceleration
		node.rotation = direction.angle() + PI
		node.get_child(0).wait_time = wind_timeout
		get_node("/root/Root/").add_child(node)
		offset += pitch
	
	
	
	
	
