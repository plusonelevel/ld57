extends Node

@onready var front_cam := $Player/FrontCamera
@onready var side_cam := $Player/SideCamera

var checkpoint_index := -1
var checkpoints: Array

func _ready() -> void:
	GameManager.camera_toggled.connect(toggle_camera)
	get_tree().paused = false
	checkpoints = $Checkpoints.get_children().map(func(child):
		if child is Node3D:
			return child.position
	)
	
func toggle_camera():
	if front_cam.current:
		side_cam.make_current()
		for collider in get_tree().get_nodes_in_group("2d_collider"):
			collider.disabled = true
	else:
		front_cam.make_current()
		for collider in get_tree().get_nodes_in_group("2d_collider"):
			collider.disabled = false

func _unhandled_input(event: InputEvent) -> void:
	if OS.is_debug_build() and event.is_action_pressed("ui_home"):
		checkpoint_index += 1
		if checkpoint_index >= checkpoints.size():
			checkpoint_index = 0
		$Player.velocity = Vector3.ZERO
		$Player.position = checkpoints[checkpoint_index]
		

func _on_death_pit_body_entered(body: Node3D) -> void:
	get_tree().reload_current_scene()
