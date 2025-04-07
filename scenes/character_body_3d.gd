extends CharacterBody3D

@onready var body: MeshInstance3D = $Body
@onready var state_machine = $Body/AnimationTree["parameters/playback"]
@onready var is_jumping = false
@onready var steps = $AudioManager/Steps
@onready var steps_2 = $AudioManager/Steps2
@onready var jump = $AudioManager/Jump
@onready var fall = $AudioManager/Fall
@onready var gong = $AudioManager/Gong



const SPEED = 4.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 20.0

signal button_pressed
signal trigger_win

enum MOVE_MODE {side, iso}
var move_mode := MOVE_MODE.side
var last_direction: Vector3
var is_button_active = false
var is_win_button_active = false

func _ready() -> void:
	GameManager.camera_toggled.connect(toggle_camera)
	last_direction = body.position

func _physics_process(delta: float) -> void:
	# Add gravity if not on floor
	if not is_on_floor():
		velocity += get_gravity() * delta
		if not is_jumping:
			is_jumping = true
			state_machine.travel("Jump")
			jump.play()
	else:
		if is_jumping:
			is_jumping = false
			fall.play()

	# Handle jump input
	if Input.is_action_just_pressed("up") and is_on_floor() and move_mode == MOVE_MODE.side:
		velocity.y = JUMP_VELOCITY
		state_machine.travel("Jump")
		jump.play()
		is_jumping = true

	var direction: Vector3
	if move_mode == MOVE_MODE.side:
		var input_dir := Input.get_axis("left", "right")
		direction = (transform.basis * Vector3(input_dir, 0, 0)).normalized()
	else:
		var input_dir := Input.get_vector("left", "right", "up", "down")
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		if not is_jumping and is_on_floor():
			state_machine.travel("Run")
			if not steps.playing and not steps_2.playing:
				play_random_steps()
		else:
			steps.stop()
			steps_2.stop()

		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		last_direction = direction
	else:
		if not is_jumping:
			state_machine.travel("Idle")
			steps.stop()
			steps_2.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	body.rotation.y = lerp_angle(body.rotation.y, atan2(-last_direction.x, -last_direction.z), delta * ROTATION_SPEED)

	move_and_slide()
	
	#handle toggle button
	if is_button_active == true:
		if Input.is_action_just_pressed("toggle_button"):
			emit_signal("button_pressed")
			gong.play()
			
	#handle win button
	if is_win_button_active == true:
		if Input.is_action_just_pressed("toggle_win"):
			emit_signal("trigger_win")
			gong.play()

func play_random_steps():
	if randi() % 2 == 0:
		steps.play()
	else:
		steps_2.play()

func toggle_camera():
	move_mode = MOVE_MODE.iso if move_mode == MOVE_MODE.side else MOVE_MODE.side


func _on_symbol_button_area_entered(_body: CharacterBody3D) -> void:
	is_button_active = true


func _on_symbol_button_area_exited(_body: CharacterBody3D) -> void:
	is_button_active = false


func _on_win_area_entered(_body: CharacterBody3D) -> void:
	is_win_button_active = true


func _on_win_area_exited(_body: CharacterBody3D) -> void:
	is_win_button_active = false
