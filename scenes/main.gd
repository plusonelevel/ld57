extends Node

@onready var front_cam := $FrontCamera
@onready var side_cam := $SideCamera

func _init() -> void:
	#front_cam.current = true
	InputListener.camera_toggled.connect(toggle_camera)
	
func toggle_camera():
	if front_cam.current:
		side_cam.make_current()
		for collider in get_tree().get_nodes_in_group("2d_collider"):
			collider.disabled = true
	else:
		front_cam.make_current()
		for collider in get_tree().get_nodes_in_group("2d_collider"):
			collider.disabled = false
