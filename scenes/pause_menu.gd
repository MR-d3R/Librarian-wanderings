extends Control

@export var world : World

func _ready():
	pass
	#hide()
	#world.connect("toggle_game_paused", _on_game_paused)



func _on_game_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()


func _on_resume_button_pressed():
	world.game_paused = false


func _on_exit_to_menu_button_pressed():
	get_tree().change_scene("res://scenes/main_menu.tscn")
