extends Node2D

var enemy = preload("res://scenes/Enemies/ram.tscn")
@onready var timer = $Timer
@onready var timer_2 = $Timer2
@onready var timer_3 = $Timer3
@onready var timer_4 = $Timer4
@onready var timer_5 = $Timer5
var rng = RandomNumberGenerator.new()

func spawn(pos):
	var instance = enemy.instantiate()
	instance.position = pos
	get_parent().add_child(instance)

func get_random_position():
	var x = rng.randf_range(2200, 4200)
	var y = rng.randf_range(540, 1100)
	return Vector2(x, y)

func _on_timer_timeout():
	spawn(get_random_position())
