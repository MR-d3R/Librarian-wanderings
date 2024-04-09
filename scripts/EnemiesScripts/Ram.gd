extends CharacterBody2D

@export var SPEED = 100.0
#@export var JUMP_VELOCITY = -400.0
var player
var direction
var max_hp = 100
var hp = max_hp

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var collision =  $Hitbox/CollisionShape2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	get_direction()
	if direction != 0:
		velocity.x = SPEED * direction
		if direction == -1:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
	else:
		attack()
	move_and_slide()
	
func get_direction():
	player = get_parent().get_node("Player")
	var player_pos = player.get_node("CollisionShape2D").global_position.x
	var enemy_pos = collision.global_position.x
	
	if player_pos + 100 < enemy_pos:
		direction = -1
	elif player_pos - 100 > enemy_pos:
		direction = 1
	else:
		direction = 0

func flip():
	facin_right = !facin_right
	scale.x = abs(scale.x) * -1
	if facin_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) * -1

func receive_damage(base_damage):
	var actual_damage = base_damage
	
func attack():
	pass
func _on_hitbox_area_entered(hitbox):
	var base_damage = hitbox.damage 
	self.hp -= base_damage
	
	
func _on_hitbox_area_entered(hitbox):
	receive_damage(hitbox)
	
	if hitbox.is_in_group("Projectile"):
		hitbox.destroy()
