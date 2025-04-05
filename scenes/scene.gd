extends Node3D

@onready var scene1 = preload("res://scenes/scene_1.tscn")
@onready var overlay = $".."

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scene+"):
		var new_scene = scene1.instantiate()
		add_child(new_scene)
		var tween = create_tween()
		tween.tween_property(overlay,"position",Vector3(0,0,0),0.5).set_trans(Tween.TRANS_CUBIC)
		
	if event.is_action_pressed("scene-"):
		var tween = create_tween()
		tween.tween_property(overlay,"position",Vector3(30,0,30),0.5).set_trans(Tween.TRANS_CUBIC)
		await tween.finished
		get_child(0).queue_free()
