extends RigidBody2D


const ROTATION_DIRECTION_SWITCH = 1
const OFF_SCREEN = 410
const PIECE_POSITION_VARIABILITY = 16
const HP_VALUE = 20
const DROP_POTENTIAL = 0.07


# The asteroids are given variable velocities
var velocity_linear = Vector2(rand_range(50,200), rand_range(100,200))
var velocity_counterclockwise = rand_range(-4, -1)
var velocity_clockwise = rand_range(1, 4)
# Will dictate the spin direction, depending on the number that rand_range() returns 
# (< 1 means spin counterclockwise and >= 1 means spin clockwise)
var rotation_direction = rand_range(0, 2)
# Will dictate the factor by which the asteroid will be scaled
var scale_factor = rand_range(1, 1.8)
var scale_vector = Vector2(scale_factor, scale_factor)
# Load explosion particles node
var explosion_scene = preload("res://particles/Explosion.tscn")
# Load asteroid pieces
var piece1_scene = preload("res://asteroids/pieces/AsteroidPiece1.tscn")
var piece2_scene = preload("res://asteroids/pieces/AsteroidPiece2.tscn")
var piece3_scene = preload("res://asteroids/pieces/AsteroidPiece3.tscn")

var pop_sound_scene = preload("res://sounds/audio-stream-players/AsteroidPop.tscn")

var explosion_color = Color(0.35, 0.35, 0.35, 1)

# Sets the drop value for this asteroid (determines whether it will drop an item)
var drop_value = rand_range(0, 1)
# Load item nodes
var item_shoot_faster = preload("res://items/ShootFaster.tscn")
var item_health = preload("res://items/Health.tscn")
# Add items to an array 
var item_list = [item_shoot_faster, item_health]

var will_drop_item
var level_node

func _ready():
	# Scale asteroid by a value in a random range
	$Sprite.scale = scale_vector
	$Collision.scale = scale_vector
	# Set downward speed of asteroid
	linear_velocity = velocity_linear
	# Set rotation speed and direction
	if (rotation_direction < ROTATION_DIRECTION_SWITCH):
		angular_velocity = velocity_counterclockwise
	else:
		angular_velocity = velocity_clockwise
	
	# Determines whether an item will drop
	if drop_value < DROP_POTENTIAL:
		will_drop_item = true
	else:
		will_drop_item = false
	
	level_node = get_parent()
	
func _physics_process(_delta):
	# If asteroid goes off the bottom of the screen, destroy it
	if position.x > OFF_SCREEN:
		queue_free()

# Called when body_entered signal is emmited on collision with another object
func _on_AsteroidLeft_body_entered(body):
	var pop_sound = pop_sound_scene.instance()
	level_node.add_child(pop_sound)
	
	# Instantiate Explosion node
	var explosion = explosion_scene.instance()
	# Set explosion's initial position to be the same as Asteroid's current position
	explosion.global_position = global_position
	# Set explosion colour to be same as asteroid's
	explosion.process_material.color = explosion_color
	# Explosion particles are now emitting
	explosion.emitting = true
	# Add explosion as a child of current level
	level_node.add_child(explosion)

	
	# If asteroid collided with player, decrease value of hp
	if body.name == "Player":
		Global.hp -= HP_VALUE
	
	# If asteroid collides with PlayerBullet
	else:
		# Spawn item upon asteroid destruction
		if will_drop_item:
			# Makes the item random
			var item = item_list[randi() % item_list.size()].instance()
			item.global_position = global_position
			item.set_linear_velocity(velocity_linear / 2)
			level_node.call_deferred("add_child", item)
			
		# Instantiate AsteroidPiece1 node
		var piece1 = piece1_scene.instance()
		# Set piece1's initial position, velocity, and scale
		piece1.position.x = position.x
		piece1.position.y = position.y - PIECE_POSITION_VARIABILITY
		piece1.set_linear_velocity(velocity_linear + Vector2(0, rand_range(-150, -50)))
		piece1.get_node("Sprite").scale = scale_vector
		piece1.get_node("Collision").scale = scale_vector
		# Add asteroid piece as a child of current level
		level_node.call_deferred("add_child", piece1)

		# Instantiate AsteroidPiece2 node
		var piece2 = piece2_scene.instance()
		# Set piece1's initial position, velocity, and scale
		piece2.position.x = position.x - PIECE_POSITION_VARIABILITY
		piece2.position.y = position.y
		piece2.set_linear_velocity(velocity_linear + Vector2(0, rand_range(-50, 50)))
		piece2.get_node("Sprite").scale = scale_vector
		piece2.get_node("Collision").scale = scale_vector
		# Add asteroid piece as a child of current level
		level_node.call_deferred("add_child", piece2)

		# Instantiate AsteroidPiece3 node
		var piece3 = piece3_scene.instance()
		# Set piece1's initial position, velocity, and scale
		piece3.position.x = position.x
		piece3.position.y = position.y + PIECE_POSITION_VARIABILITY
		piece3.set_linear_velocity(velocity_linear + Vector2(0, rand_range(50, 150)))
		piece3.get_node("Sprite").scale = scale_vector
		piece3.get_node("Collision").scale = scale_vector
		# Add asteroid piece as a child of current level
		level_node.call_deferred("add_child", piece3)
	
	# Remove Asteroid and all its children from the queue
	queue_free()
