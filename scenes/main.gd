extends Node

@onready var front_cam := $Player/FrontCamera
@onready var side_cam := $Player/SideCamera

func _ready() -> void:
	GameManager.camera_toggled.connect(toggle_camera)
	get_tree().paused = true
	
func toggle_camera():
	if front_cam.current:
		side_cam.make_current()
		for collider in get_tree().get_nodes_in_group("2d_collider"):
			collider.disabled = true
	else:
		front_cam.make_current()
		for collider in get_tree().get_nodes_in_group("2d_collider"):
			collider.disabled = false
