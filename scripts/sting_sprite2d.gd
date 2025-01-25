extends Sprite2D

@export var sting_speed = 0.0
@export var dir = Vector2(0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#var dir = Vector2.from_angle(rotation)
	#dir = dir.rotated(-PI/2)
	position += dir * sting_speed * delta
	
	pass

func _on_lifetime_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Bubble:
		body.pop()
