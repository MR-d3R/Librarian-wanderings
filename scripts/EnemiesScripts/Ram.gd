extends CharacterBody2D

@export var SPEED = 100.0
@export var MAX_HP = 100
#@export var JUMP_VELOCITY = -400.0
var hp = MAX_HP

var facin_right = true
var player
var direction = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var collision =  $Hitbox/CollisionShape2D

var line_of_sight = false
@onready var los = $LineOfSight

func _physics_process(delta):
	get_direction()
	lineofsight()
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.x = SPEED * direction
	flip()
	move_and_slide()
	
func get_direction():
	player = get_parent().get_node("Player")
	var player_pos = player.get_node("CollisionShape2D").global_position.x
	var enemy_pos = collision.global_position.x
	var flip_range = 0
	if player_pos < enemy_pos - flip_range and line_of_sight == true or line_of_sight == false and direction == 1 and $Area2D.has_overlapping_bodies():
		direction = -1
	elif player_pos > enemy_pos + flip_range and line_of_sight == true or line_of_sight == false and direction == -1 and $Area2D.has_overlapping_bodies():
		direction = 1

func flip():
	if direction == 1:
		transform.x.x = -1
	if direction == -1:
		transform.x.x = 1

func lineofsight():
	los.look_at(player.global_position)
	if los.get_collider() == player and los.get_collider() != Environment:
		line_of_sight = true
		print("true")
	else:
		line_of_sight = false
		
func receive_damage(base_damage):
	var actual_damage = base_damage
	
func attack():
	pass
	#
#func _on_hitbox_area_entered(hitbox):
	#var base_damage = hitbox.damage 
	#self.hp -= base_damage
	#
	
func _on_hitbox_area_entered(hitbox):
	receive_damage(hitbox)
	
	if hitbox.is_in_group("Projectile"):
		hitbox.destroy()
