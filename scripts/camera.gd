extends Camera2D

@export var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_node("/root/Root/Player").controlled
	if player:
		position = lerp(position, player.position, speed * delta)
