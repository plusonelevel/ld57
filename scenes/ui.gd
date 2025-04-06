extends Control

@onready var pause_menu: VBoxContainer = $PauseMenu
@onready var settings_menu: VBoxContainer = $SettingsMenu
@onready var start_menu: VBoxContainer = $StartMenu
@onready var symbol: TextureRect = $Symbol
@onready var ivc: SubViewportContainer = $"../IntroViewportContainer"

func _ready() -> void:
	start_menu.show()
	symbol.show()
	ivc.show()

func handle_pause() -> void:
	pause_menu.visible = !pause_menu.visible
	get_tree().paused = !get_tree().paused

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_start_button_pressed() -> void:
	get_tree().paused = false
	start_menu.hide()
	symbol.hide()
	ivc.hide()
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
