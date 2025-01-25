extends CharacterBody2D


@export var SPEED = 300.0
@export var hit_rate = 0.5
@export var bee_velocity = 100.0
@export var sting_velocity = 500.0

func _ready():
	$AnimatedSprite2D.play("regular_smile")

func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var player = get_node("/root/Root/Player")
	if player.controlled == null:
		return
	var dir = (player.controlled.position - position).normalized() 
	var query = PhysicsRayQueryParameters2D.create(position, dir*200.0)
	var result = space_state.intersect_ray(query)
	if result.size() != 0:
		if result["collider"] == player.controlled:
			velocity = bee_velocity * dir
			$StingSprite.rotation = (dir * Vector2(-1, 1)).angle_to(Vector2(0, 1))
			$StingSprite.dir = dir
			$StingSprite.sting_speed = 500.0
			
	move_and_slide()
