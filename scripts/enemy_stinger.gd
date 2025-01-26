extends CharacterBody2D

@export var SPEED = 300.0
@export var attack_area = 400.0
@export var bee_velocity = 200.0
@export var sting_velocity = 500.0

@onready var audio_summen: AudioStreamPlayer = $Audio_summen
@onready var audio_sting_1: AudioStreamPlayer = $Audio_sting1
@onready var audio_sting_2: AudioStreamPlayer = $Audio_sting2

var sting_fired = false

func _ready():
	$AnimatedSprite2D.play("regular_smile")

func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var player = get_node("/root/Root/Player")
	if player.controlled == null:
		return
	var dir = (player.controlled.position - position).normalized()
	var query = PhysicsRayQueryParameters2D.create(position, position + dir * attack_area)
	var result = space_state.intersect_ray(query)
	print(result)
	if result.size() != 0:
		if result["collider"] == player.controlled:
			$AnimatedSprite2D.play("angry")
			velocity = bee_velocity * dir
			if audio_summen.playing == false:
				audio_summen.play()
			
			if not sting_fired:
				#velocity = bee_velocity * dir
				audio_sting_1.play()
				audio_sting_2.play()
				$StingSprite.rotation = (dir * Vector2(-1, 1)).angle_to(Vector2(0, 1))
				$StingSprite.dir = dir
				$StingSprite.sting_speed = sting_velocity
				$StingSprite.reparent(get_node("/root/Root/"))
				sting_fired = true
		else:
			$AnimatedSprite2D.play("regular_smile")
			velocity = Vector2(0.0, 0.0)
	else:
		$AnimatedSprite2D.play("regular_smile")
		velocity = Vector2(0, 0)
			
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Bubble:
		body.pop()
