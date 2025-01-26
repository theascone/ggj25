extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	var scene = preload("res://scenes/you_won.tscn")
	var instance = scene.instantiate()
	get_node("/root/Root/Camera2D").add_child(instance)
	instance.z_index = 100
