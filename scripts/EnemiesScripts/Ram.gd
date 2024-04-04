extends CharacterBody2D

@export var SPEED = -300.0
#@export var JUMP_VELOCITY = -400.0
var facin_right = false
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
	velocity.x = SPEED * direction
	move_and_slide()
	
func get_direction():
	player = get_parent().get_node("Player")
	if player.get_node("CollisionShape2D").global_position.x < collision.global_position.x-22:
		direction = 1
	elif player.get_node("CollisionShape2D").global_position.x > collision.global_position.x-22:
		direction = -1
	else:
		direction = 0

func flip():
	facin_right = !facin_right
	scale.x = abs(scale.x) * -1
	if facin_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) * -1


func _on_hitbox_area_entered(hitbox):
	var base_damage = hitbox.damage 
	self.hp -= base_damage
	print(hitbox.get_parent().name + "'s hitbox touched " + name + "'s hurtbox and dealt " + str(base_damage))
