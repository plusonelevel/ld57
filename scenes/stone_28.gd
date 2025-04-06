extends StaticBody3D

var original_position: Vector3
var time := 0.0
var amplitude := 2.0 
var speed := 1.0 

func _ready():
	original_position = position

func _process(delta):
	time += delta
	position.z = original_position.z + sin(time * speed) * amplitude
