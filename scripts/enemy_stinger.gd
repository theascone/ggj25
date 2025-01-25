extends CharacterBody2D


@export var SPEED = 300.0
@export var hit_rate = 0.5

func _ready():
	$AnimatedSprite2D.play("regular_smile")

func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var player = get_node("/root/Root/Player").controlled
	var query = PhysicsRayQueryParameters2D.create(position, player.position)
	var result = space_state.intersect_ray(query)
	print(result)
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Bubble:
		body.pop()

func _on_timer_timeout() -> void:
	var bullet = preload("res://scenes/sting_bullet.tscn")
	var bullet_instance = bullet.instantiate()
	var player = get_node("/root/Root/Player")
	var dir = (player.controlled.position - position).normalized() 
	bullet_instance.position = position
	bullet_instance.rotation = (dir * Vector2(-1, 1)).angle_to(Vector2(0, -1))
	
	add_child(bullet_instance)
