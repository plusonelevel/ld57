extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

enum MOVE_MODE {xy, xz}
var move_mode := MOVE_MODE.xy

func _init() -> void:
	InputListener.camera_toggled.connect(toggle_camera)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor() and move_mode == MOVE_MODE.xy:
		velocity.y = JUMP_VELOCITY

	var direction: Vector3
	if move_mode == MOVE_MODE.xy:
		var input_dir := Input.get_axis("ui_left", "ui_right")
		direction = (transform.basis * Vector3(input_dir, 0, 0)).normalized()
	else:
		var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func toggle_camera():
	move_mode = MOVE_MODE.xz if move_mode == MOVE_MODE.xy else MOVE_MODE.xy

	
