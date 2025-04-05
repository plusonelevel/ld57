extends Area3D

func _on_body_entered(body: Node3D) -> void:
	GameManager.goal_reached.emit()
