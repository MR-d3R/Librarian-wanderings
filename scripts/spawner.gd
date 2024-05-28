extends Node2D

var enemy = preload("res://scenes/Enemies/ram.tscn")
@onready var timer = $Timer
		

func spawn(pos):
	var instance = enemy.instantiate()
	instance.position = pos
	get_parent().add_child(instance)


func _on_timer_timeout():
	spawn(Vector2(2500, 500))
