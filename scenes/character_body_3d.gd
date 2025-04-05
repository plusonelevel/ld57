extends CharacterBody3D

var speed = 5.0
var gravity = -9.8

func _physics_process(delta: float) -> void:
	var input_direction = Vector3.ZERO
	velocity.y += gravity * delta
	
	if Input.is_action_pressed("up"):
		input_direction.z -= 1
	if Input.is_action_pressed("down"):
		input_direction.z += 1
	if Input.is_action_pressed("left"):
		input_direction.x -= 1
	if Input.is_action_pressed("right"):
		input_direction.x += 1
	
	input_direction = input_direction.normalized()
	velocity.x = input_direction.x * speed
	velocity.z = input_direction.z * speed
	
	move_and_slide()
