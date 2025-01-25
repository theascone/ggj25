extends AnimatedSprite2D

@export var speed = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = speed.angle() + 1.5 * PI
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += speed * delta

func exited(body: Node2D):
	queue_free()
