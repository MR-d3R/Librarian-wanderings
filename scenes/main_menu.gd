class_name MainMenu
extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/start_button as Button
@onready var settings_button = $MarginContainer/HBoxContainer/VBoxContainer/settings_button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/exit_button as Button

@export var start_level = preload("res://scenes/game.tscn") as PackedScene
@export var settings_menu = preload("res://scenes/settings_container.tscn") as PackedScene

var arrow = load("res://assests/textures/Cursor Default.png")

func _ready():
	Input.set_custom_mouse_cursor(arrow)
	
	start_button.button_down.connect(on_start_pressed)
	settings_button.button_down.connect(on_settings_pressed)
	exit_button.button_down.connect(on_exit_pressed)

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
	

func on_settings_pressed() -> void:
	get_tree().change_scene_to_packed(settings_menu)
	
func on_exit_pressed() -> void:
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
