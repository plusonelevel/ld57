extends StaticBody3D

@onready var symbol: MeshInstance3D = $Symbol

var original_position: Vector3
var original_color: Color
var original_emission_enabled: bool

var time := 0.0
var amplitude := 2.0 
var speed := 1.0 
var is_active := false

func _ready():
	original_position = position
	var mat = symbol.get_active_material(0)
	if mat and mat is StandardMaterial3D:
		original_color = mat.albedo_color
		original_emission_enabled = mat.emission_enabled

func _process(delta):
	if is_active:
		time += delta
		position.z = original_position.z + (sin(time * speed) + 1.0) * (amplitude / 2.0)

func _on_button_pressed():
	if !is_active:
		var current_offset = position.z - original_position.z
		var target_value = (current_offset / (amplitude / 2.0)) - 1.0
		time = asin(clamp(target_value, -1.0, 1.0)) / speed

	is_active = !is_active

	var mat = symbol.get_active_material(0)
	if mat and mat is StandardMaterial3D:
		if is_active:
			mat.albedo_color = Color(0.953, 0.031, 0.22)          
			mat.emission_enabled = true
		else:
			mat.albedo_color = original_color
			mat.emission_enabled = original_emission_enabled
