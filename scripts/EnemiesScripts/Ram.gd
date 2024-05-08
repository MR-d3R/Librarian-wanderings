extends CharacterBody2D

@export var SPEED = 150
@export var MAX_HP = 100
var hp = MAX_HP

var facin_right = true
var player
var direction = Vector2.RIGHT
var knockback_strength = 32
var knockback = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var collision =  $Hitbox/CollisionShape2D
@onready var attack_timer = $AttackTimer

var line_of_sight = false
@onready var los = $LineOfSight

func _physics_process(delta):
	get_direction()
	lineofsight()
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity = SPEED * direction - knockback * knockback_strength
	flip()
	move_and_slide()
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	
func get_direction():
	player = get_parent().get_node("Player")
	var player_pos = player.get_node("CollisionShape2D").global_position.x
	var enemy_pos = collision.global_position.x
	var flip_range = 100
	if player_pos < enemy_pos - flip_range and line_of_sight == true or line_of_sight == false and direction == Vector2.RIGHT and $Area2D.has_overlapping_bodies():
		direction = Vector2.LEFT
	elif player_pos > enemy_pos + flip_range and line_of_sight == true or line_of_sight == false and direction == Vector2.LEFT and $Area2D.has_overlapping_bodies():
		direction = Vector2.RIGHT
	elif player_pos <= enemy_pos + flip_range and player_pos >= enemy_pos - flip_range and line_of_sight:
		direction = Vector2.ZERO

func flip():
	if direction == Vector2.RIGHT:
		transform.x.x = -1
	if direction == Vector2.LEFT:
		transform.x.x = 1

func lineofsight():
	los.look_at(player.global_position)
	if los.get_collider() == player and los.get_collider() != Environment:
		line_of_sight = true
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
	
#func _on_hitbox_area_entered(hitbox):
	#receive_damage(hitbox)
	#var hit_direction = global_position.direction_to(collision)
	#velocity -= hit_direction * knockback_strength
	#
	#if hitbox.is_in_group("Projectile"):
		#hitbox.destroy()


func _on_hurt_box_area_entered(area):
	receive_damage(area)
	#var player_to_bullet = player.global_position.direction_to(area.global_position)
	#var knockback = player_to_bullet * knockback_strength
	#velocity -= knockback
	var direction = global_position.direction_to(area.global_position)
	var explosion_force = direction * knockback_strength
	knockback = explosion_force
	
	if area.is_in_group("Projectile"):
		area.destroy()
