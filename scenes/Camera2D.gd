extends Camera2D

const CAMERA_MOVEMENT_SPEED : int = 0
const CAMERA_LEFT_LIMIT : int = -1400
const CAMERA_RIGHT_LIMIT : int = 1920
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_pressed("ui_left") and position.x > CAMERA_LEFT_LIMIT):
		position.x -= CAMERA_MOVEMENT_SPEED
	if (Input.is_action_pressed("ui_right") and position.x < CAMERA_RIGHT_LIMIT):
		position.x += CAMERA_MOVEMENT_SPEED
