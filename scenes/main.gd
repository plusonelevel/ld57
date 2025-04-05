extends Node

@onready var front_cam := $FrontCamera
@onready var side_cam := $SideCamera

@onready var c_box_front := $Node3D/Box/CollisionFront
@onready var c_column_front := $Node3D/Column/CollisionFront
@onready var c_plaform_front := $Node3D/Platform/CollisionFront
@onready var c_point_front := $Node3D/Point/CollisionFront

func _init() -> void:
	#front_cam.current = true
	InputListener.camera_toggled.connect(toggle_camera)
	
func toggle_camera():
	if front_cam.current:
		side_cam.make_current()
		c_box_front.disabled = true
		c_column_front.disabled = true
		c_plaform_front.disabled = true
		c_point_front.disabled = true
	else:
		front_cam.make_current()
		c_box_front.disabled = false
		c_column_front.disabled = false
		c_plaform_front.disabled = false
		c_point_front.disabled = false
