extends Node2D

signal status_change(status)

var done = false
var button1 = false
var button2 = false
var button3 = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	status_change.emit(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func eval():
	if done:
		return
	if button1 and button2 and button3:
		status_change.emit(true)

func _on_button_1_status_change(status: bool) -> void:
	button1 = status
	eval()

func _on_button_2_status_change(status: bool) -> void:
	button2 = status
	eval()

func _on_button_3_status_change(status: bool) -> void:
	button3 = status
	eval()
