extends CharacterBody2D


@export var SPEED = -300.0
#@export var JUMP_VELOCITY = -400.0
var facin_right = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = SPEED
	
	if $RayCast2D.is_colliding() and is_on_floor():
		flip()
	move_and_slide()
	
func flip():
	facin_right = !facin_right
	scale.x = abs(scale.x) * -1
	if facin_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) * -1
