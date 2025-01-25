class_name Bubble
extends CharacterBody2D


@export var dampening = 0.9
@export var sine_amplitude = 250.0
@export var sine_frequency = 0.0035
@export var surface = 10.0

@export var removing = false

func _ready():
	update_surface(1)

func add_velocity(velocity: Vector2):
	self.velocity += velocity
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	velocity += get_gravity() * delta

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity += Vector2(0.0, sin(Time.get_ticks_msec()*sine_frequency))

	velocity = lerp(velocity, Vector2(0.0, 0.0), dampening * delta)

	move_and_slide()
	
func update_surface(factor: float):
	surface *= factor
	var new_scale = sqrt(surface/PI)
	scale.x = new_scale
	scale.y = new_scale
		
func pop() -> void:
	#death_animation()
	var player = get_node("/root/Root/Player")
	player.handle_popped(self)
	queue_free()

func death_animation() -> void:
	print("ded")


func _on_spike_body_entered(body) -> void:
	pop()


func _on_merge_area_body_entered(body: Node2D) -> void:
	var player = get_node("/root/Root/Player")

	var bubble := body as Bubble
	if bubble == null or bubble == self:
		return
	if player.bubble_recently_created(bubble) or player.bubble_recently_created(self):
		return
	if removing or bubble.removing:
		return

	position = lerp(position, bubble.position, surface / (surface + bubble.surface))
	surface += bubble.surface
	update_surface(1)

	if player.controlled == bubble:
		player.controlled = self
		
	bubble.removing = true
	bubble.queue_free()
