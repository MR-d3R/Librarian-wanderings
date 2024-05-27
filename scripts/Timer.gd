extends Panel

var time: float = 10000.0
var min: int = 0
var sec: int = 0
var msec: int = 0

func _process(delta) -> void:
	time -= delta
	msec = fmod(time, 1) * 100
	sec = fmod(time, 60)
	min = fmod(time, 3600) / 60
	$Minutes.text = "%02d" % min
	$Seconds.text = "%02d" % sec
	$MSeconds.text = "%03d" % msec
	if time <= 0:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
