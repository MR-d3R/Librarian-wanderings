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



#func _on_exit_button_clicked():
	#get_tree().change_scene("res://scenes/main_menu.tscn")
