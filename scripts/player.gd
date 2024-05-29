extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var MAX_HP = 100
var hp = MAX_HP
signal hp_signal(hp)
# et the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity = 1000
@export var MAX_VELOCITY = 1000

@onready var ap = $AnimatedSprite2D
@onready var FireBall = preload("res://scenes/Projectiles/fire_ball.tscn") as PackedScene
@onready var attack_timer = $betweenAttackTimer
@onready var animation_attack_timer = $AttackTimer

var knockback_strength = 16
var knockback = Vector2.ZERO
var direction_to = Vector2.RIGHT

var current_state = "idle2"
var is_attacking = false

func _input(event):
	if event.is_action_pressed("attack"):
		if !is_attacking:
			start_attack()

func start_attack():
	is_attacking = true
	animation_attack_timer.start()
	ap.play("attack")

func _on_attack_timer_timeout():
	is_attacking = false

func _physics_process(delta):
	emit_signal("hp_signal", hp)
	# Add the gravity.
	if is_attacking:
		velocity = Vector2.ZERO
	
	if hp <= 0:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	if not is_on_floor():
		if is_attacking:
			velocity.y += gravity*10*delta
		velocity.y += gravity * delta
		if velocity.y > MAX_VELOCITY:
			velocity.y = MAX_VELOCITY

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction and !is_attacking:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#if knockback != Vector2.ZERO:
		#velocity = SPEED * direction_to - knockback * knockback_strength
		#knockback = lerp(knockback, Vector2.ZERO, 0.1)
		#direction_to = lerp(knockback, Vector2.ZERO, 0.1)
		#if direction:
			#knockback=Vector2.ZERO
		
	
	if direction != 0:
		switch_direction(direction)
		
	if Input.is_action_just_pressed("attack") and attack_timer.is_stopped():
		var fireball_direction = self.global_position.direction_to(get_global_mouse_position())
		fireball_attack(fireball_direction, velocity.x)

	move_and_slide()
	
	update_animations(direction)
	
func update_animations(direction):
	if is_attacking == false:
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


#func _on_hurt_box_area_entered(area):
	#var direction_to = global_position.direction_to(area.global_position)
	#var explosion_force = direction_to * knockback_strength
	#knockback = explosion_force
	#direction_to = direction_to.normalized()
	#knockback = knockback.normalized()

