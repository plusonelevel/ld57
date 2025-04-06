extends Node

signal goal_reached
signal camera_toggled
signal game_paused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	goal_reached.connect(handle_goal_reached)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func handle_goal_reached() -> void:
	get_tree().quit()
