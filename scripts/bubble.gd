class_name Bubble
extends CharacterBody2D


@export var dampening = 0.9
@export var sine_amplitude = 250.0
@export var sine_frequency = 0.0035
@export var initial_surface = 100.0
@export var surface = initial_surface

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

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
	
func update_surface(factor: float):
	surface *= factor
	factor = sqrt(factor)
	scale.x *= factor
	scale.y *= factor
		
func pop() -> void:
	#death_animation()
	var player = get_node("/root/Root/Player")
	player.handle_popped(self)
	queue_free()

func death_animation() -> void:
	print("ded")
