extends CharacterBody3D

@onready var body: MeshInstance3D = $Body

const SPEED = 4.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 20.0

enum MOVE_MODE {side, iso}
var move_mode := MOVE_MODE.side
var last_direction: Vector3

func _ready() -> void:
	GameManager.camera_toggled.connect(toggle_camera)
	last_direction = body.position

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor() and move_mode == MOVE_MODE.side:
		velocity.y = JUMP_VELOCITY

	var direction: Vector3
	if move_mode == MOVE_MODE.side:
		var input_dir := Input.get_axis("ui_left", "ui_right")
		direction = (transform.basis * Vector3(input_dir, 0, 0)).normalized()
	else:
		var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		last_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	body.rotation.y = lerp_angle(body.rotation.y, atan2(-last_direction.x, -last_direction.z), delta * ROTATION_SPEED)

	move_and_slide()

func toggle_camera():
	move_mode = MOVE_MODE.iso if move_mode == MOVE_MODE.side else MOVE_MODE.side

	
