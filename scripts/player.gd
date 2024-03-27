extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity = 1000
@export var MAX_VELOCITY = 1000

@onready var ap = $AnimatedSprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > MAX_VELOCITY:
			velocity.y = MAX_VELOCITY

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction != 0:
		switch_direction(direction)

	move_and_slide()
	
	update_animations(direction)
	
func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			ap.play("idle")
		else:
			ap.play("walk")
	else:
		if velocity.y > 0:
			ap.play("falling")
		else:
			ap.play("jump")

func switch_direction(direction):
	ap.flip_h = (direction == -1)
	if direction == -1:
		ap.position.x = -9
	else:
		ap.position.x = 20
		
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					ap.play("attack")
