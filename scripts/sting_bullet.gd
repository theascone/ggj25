extends Area2D

@export var speed = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var dir = Vector2.from_angle(rotation)
	dir = dir.rotated(-PI/2)
	position += dir.normalized() * speed * delta
	pass


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Bubble:
		body.pop()
