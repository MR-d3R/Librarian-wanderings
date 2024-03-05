extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity = 1000
@export var MAX_VELOCITY = 1000

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > MAX_VELOCITY:
			velocity.y = MAX_VELOCITY

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction != 0:
		switch_direction(direction)

	move_and_slide()
	
	update_animations(direction)
	
func update_animations(direction):
	#if is_on_floor():
	if direction == 0:
		ap.play("idle")
	else:
		ap.play("walk")
	print(direction)
	#else:
		#ap.play("idle")

func switch_direction(direction):
	sprite.flip_h = (direction == -1)
	sprite.position.x = direction * 15
