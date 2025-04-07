extends Node
@onready var gong_1 = $Gong1
@onready var gong_2 = $Gong2


func _on_mouse_entered():
	gong_1.play()


func _on_pressed():
	gong_2.play()
