extends StaticBody3D

@onready var symbol: MeshInstance3D = $Symbol


var original_position: Vector3
var time := 0.0
var amplitude := 2.0 
var speed := 1.0 
var is_active := false

func _ready():
	original_position = position

func _process(delta):
	if is_active:
		time += delta
		position.z = original_position.z + sin(time * speed) * amplitude

func _on_button_pressed():
	is_active = true
	var mat = symbol.get_active_material(0)
	if mat and mat is StandardMaterial3D:
		mat.albedo_color = Color(0.953, 0.031, 0.22)            
		mat.emission_enabled = true  
