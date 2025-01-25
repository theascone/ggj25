extends Area2D

@export var min_surface = 1

signal status_change(status)

var bubbles = []
var active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	status_change.emit(active)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	maintain_button()
	
func any_bubble():
	for bubble in bubbles:
		if bubble.surface >= min_surface:
			return true
	return false
	
func maintain_button():
	var should_activate = any_bubble()
	
	if should_activate != active:
		active = should_activate
		status_change.emit(active)

func _on_body_entered(body: Node2D) -> void:
	var bubble := body as Bubble
	if bubble == null:
		return
	bubbles.append(bubble)
	maintain_button()	

func _on_body_exited(body: Node2D) -> void:
	var bubble := body as Bubble
	if bubble == null or bubble.surface < min_surface:
		return
	bubbles.erase(bubble)
	maintain_button()
