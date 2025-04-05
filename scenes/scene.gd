extends Node3D

@onready var scene1 = preload("res://scenes/scene_1.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scene+"):
		var new_scene = scene1.instantiate()
		add_child(new_scene)
	if event.is_action_pressed("scene-"):
		get_child(0).queue_free()
