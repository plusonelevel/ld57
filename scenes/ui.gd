extends Control

@onready var pause_menu: Control = $PauseMenu
@onready var settings_menu: VBoxContainer = $SettingsMenu
@onready var start_menu: Control = $StartMenu
@onready var guide_c: Control = $GuideC
@onready var guide_x: Control = $GuideX
@onready var guide_e: Control = $GuideE
@onready var win_menu: Control = $WinMenu

func _ready() -> void:
	start_menu.show()

func handle_pause() -> void:
	pause_menu.visible = !pause_menu.visible
	get_tree().paused = !get_tree().paused

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_start_button_pressed() -> void:
	get_tree().paused = false
	start_menu.hide()
	GameManager.game_paused.emit()
	GameManager.game_paused.connect(handle_pause)

func _on_resume_button_pressed() -> void:
	GameManager.game_paused.emit()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		GameManager.game_paused.emit()
	elif event.is_action_pressed("ui_accept") and start_menu.visible:
		_on_start_button_pressed()
	


func _on_back_button_pressed() -> void:
	settings_menu.hide()
	start_menu.show()


func _on_symbol_button_area_entered(other) -> void:
	if other is CharacterBody3D:
		guide_c.show()


func _on_symbol_button_area_exited(other) -> void:
	if other is CharacterBody3D:
		guide_c.hide()


func _on_perspective_area_entered(other) -> void:
	if other is CharacterBody3D:
		guide_x.show()


func _on_perspective_area_exited(other) -> void:
	if other is CharacterBody3D:
		guide_x.hide()


func _on_win_area_entered(other) -> void:
	if other is CharacterBody3D:
		guide_e.show()


func _on_win_area_exited(other) -> void:
	if other is CharacterBody3D:
		guide_e.hide()


func _on_player_trigger_win() -> void:
	win_menu.show()
	get_tree().paused = !get_tree().paused
