extends Node3D

@onready var stone: MeshInstance3D = $Ring/Stone
@onready var stone_2: MeshInstance3D = $Stone2
@onready var stone_3: MeshInstance3D = $Stone3
@onready var stone_4: MeshInstance3D = $Ring/Stone4
@onready var stone_5: MeshInstance3D = $Ring/Stone5
@onready var stone_6: MeshInstance3D = $Stone6
@onready var ring: Node3D = $Ring


func _process(delta: float) -> void:
	rotation.y += 0.1 * delta
	stone.rotation.z += 1.0 * delta
	stone_2.rotation.y += 1.2 * delta
	stone_3.rotation.y += 0.1 * delta
	stone_4.rotation.x += 0.6 * delta
	stone_5.rotation.y += 1.5 * delta
	stone_6.rotation.z += 1.3 * delta
	ring.rotation.y += 0.3 * delta
