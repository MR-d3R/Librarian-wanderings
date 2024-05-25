extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var MAX_HP = 10
var hp = MAX_HP
# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity = 1000
@export var MAX_VELOCITY = 1000

@onready var ap = $AnimatedSprite2D
@onready var FireBall = preload("res://scenes/Projectiles/fire_ball.tscn") as PackedScene
@onready var attack_timer = $AttackTimer
var current_state = "idle2"
var is_attacking = false

func _physics_process(delta):
	# Add the gravity.
	if hp <= 0:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
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
		
	if Input.is_action_just_pressed("attack") and attack_timer.is_stopped():
		var fireball_direction = self.global_position.direction_to(get_global_mouse_position())
		fireball_attack(fireball_direction, velocity.x)

	move_and_slide()
	
	update_animations(direction)
	
func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			ap.play("idle2")
		else:
			ap.play("walk")
	else:
		if velocity.y > 0:
			ap.play("jump")
		else:
			ap.play("fall")

func switch_direction(direction):
	if direction == -1:
		transform.x.x = -1
	else:
		transform.x.x = 1
		
func fireball_attack(fireball_direction: Vector2, xvelocity): 
	if FireBall:
		var fireball = FireBall.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
		get_tree().current_scene.add_child(fireball)
		fireball.global_position = self.global_position
		
		var fireball_rotation = fireball_direction.angle() 
		fireball.rotation = fireball_rotation
		
		attack_timer.start()
