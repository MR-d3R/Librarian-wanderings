extends CharacterBody2D

@export var SPEED = 100.0
@export var MAX_HP = 100
#@export var JUMP_VELOCITY = -400.0
var line_of_sight = false
var player
var direction = 1
var max_hp = 100
var hp = max_hp
var facin_right = true
var knockback_strength = 64

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var collision =  $Hitbox/CollisionShape2D
@onready var attack_timer = $AttackTimer

func _physics_process(delta):
	get_direction()
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
	if player_pos + flip_range < enemy_pos and line_of_sight == true or line_of_sight == false and direction == 1 and $Area2D.has_overlapping_bodies():
		direction = -1
	elif player_pos - flip_range > enemy_pos and line_of_sight == true or line_of_sight == false and direction == -1 and $Area2D.has_overlapping_bodies():
		direction = 1

func flip():
	if direction == 1:
		transform.x.x = -1
	if direction == -1:
		transform.x.x = 1

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
	var hit_direction = global_position.direction_to(collision)
	velocity -= hit_direction * knockback_strength
	
	if hitbox.is_in_group("Projectile"):
		hitbox.destroy()


func _on_hurt_box_area_entered(area):
	receive_damage(area)
	player = get_parent().get_node("Player")
	var player_to_bullet = player.global_position.direction_to(area.global_position)
	var knockback = player_to_bullet * knockback_strength
	velocity -= knockback
	
	if area.is_in_group("Projectile"):
		area.destroy()
