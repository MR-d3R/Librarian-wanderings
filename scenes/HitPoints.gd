extends Panel

var player

func _process(delta):
	player = get_parent().get_node("Player")
	$Label.text = "%03d" % player.hp
