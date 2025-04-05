extends Camera3D

@export var front_position := Vector3(0, 1, 5)
@export var front_rotation := Vector3(0, 0, 0)
@export var iso_position := Vector3(-3, 2.2, 3.4)
@export var iso_rotation := Vector3(-22.4, -38.9, 5)

func _init() -> void:
	position = front_position
	InputListener.camera_toggled.connect(toggle_camera)
	
func toggle_camera():
	if position == front_position:
		position = iso_position
		rotation = iso_rotation
	else:
		position = front_position
		rotation = front_rotation
