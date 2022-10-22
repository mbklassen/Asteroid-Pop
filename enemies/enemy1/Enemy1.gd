extends RigidBody2D

const HP_VALUE = 20
const DROP_POTENTIAL = 0.16
const OFF_SCREEN = 660

var explosion_particles_scene = preload("res://particles/Explosion.tscn")
var explosion_particles_color = Color(0.8, 0.65, 0.1, 1)
var explosion_scene = preload("res://explosions/ExplosionMedium.tscn")

var explosion_sound_scene = preload("res://sounds/audio-stream-players/Explosion1.tscn")

var drop_value = rand_range(0, 1)
var item_shoot_faster = preload("res://items/ShootFaster.tscn")
var item_health = preload("res://items/Health.tscn")
var item_list = [item_shoot_faster, item_health]
var velocity_linear = Vector2(0, 200)

var will_drop_item
var level_node

func _ready():
	# Determines whether an item will drop
	if drop_value < DROP_POTENTIAL:
		will_drop_item = true
	else:
		will_drop_item = false
		
	level_node = get_parent()
	linear_velocity = velocity_linear
	
func _physics_process(_delta):
	# If asteroid goes off the bottom of the screen, destroy it
	if position.y > OFF_SCREEN:
		queue_free()

# When enemy is hit by a bullet or the player, destroy the enemy
func _on_Enemy1_body_entered(body):
	# Creates an explosion sound
	var explosion_sound = explosion_sound_scene.instance()
	level_node.add_child(explosion_sound)
	
	# Creates an explosion animation
	var explosion = explosion_scene.instance()
	explosion.global_position = global_position
	level_node.call_deferred("add_child", explosion)
	
	# Instantiate explosion particles node
	var explosion_particles = explosion_particles_scene.instance()
	explosion_particles.global_position = global_position
	# Set explosion colour to be same as enemy's
	explosion_particles.process_material.color = explosion_particles_color
	# Explosion particles are now emitting
	explosion_particles.emitting = true
	# Add explosion_particles as a child of current level node
	level_node.call_deferred("add_child", explosion_particles)
	
	# If the colliding body was the player, then decrease player's hp
	if body.name == "Player":
		Global.hp -= HP_VALUE
	# Else if the colliding body was player's bullet, maybe spawn an item
	else:
		# Spawns a random item on enemy destruction
		if will_drop_item:
			var item = item_list[randi() % item_list.size()].instance()
			item.global_position = global_position
			item.set_linear_velocity(velocity_linear / 2)
			level_node.call_deferred("add_child", item)
			
	queue_free()
