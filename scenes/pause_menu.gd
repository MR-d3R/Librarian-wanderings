extends Control

@export var game_manager : GameManager

func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_toggle_is_paused)

func _process(delta):
	pass

func _on_game_toggle_is_paused(game_paused: bool):
	if game_paused:
		show()
	else:
		hide()

func _on_resume_button_pressed():
	game_manager.game_paused = false


func _on_exit_to_menu_button_pressed():
	game_manager.game_paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
