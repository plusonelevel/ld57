extends CanvasItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.get_name() == "Web":
		hide()
