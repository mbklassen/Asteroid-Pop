extends RigidBody2D


const ROTATION_DIRECTION_SWITCH = 1
const OFF_SCREEN = 660
const PIECE_POSITION_VARIABILITY = 16


# the asteroids are given variable velocities
var velocity_linear = Vector2(0, rand_range(100, 300))
var velocity_counterclockwise = rand_range(-4, -1)
var velocity_clockwise = rand_range(1, 4)
# Will dictate the spin direction, depending on the number that rand_range() returns 
# (< 1 means spin counterclockwise and >= 1 means spin )
var rotation_direction = rand_range(0, 2)
# Will dictate the factor by which the asteroid will be scaled
var scale_factor = rand_range(1, 1.8)
var scale_vector = Vector2(scale_factor, scale_factor)
# load explosion particles node
var explosion_scene = preload("res://particles/Explosion.tscn")
var piece1_scene = preload("res://asteroids/pieces/AsteroidPiece1.tscn")
var piece2_scene = preload("res://asteroids/pieces/AsteroidPiece2.tscn")
var piece3_scene = preload("res://asteroids/pieces/AsteroidPiece3.tscn")

var explosion_color = Color(0.35, 0.35, 0.35, 1)

var healthbar


func _ready():
	# Scale asteroid by a value in a random range
	$Sprite.scale = scale_vector
	$CollisionShape2D.scale = scale_vector
	# Set downward speed of asteroid
	linear_velocity = velocity_linear
	# Set rotation speed and direction
	if (rotation_direction < ROTATION_DIRECTION_SWITCH):
		angular_velocity = velocity_counterclockwise
	else:
		angular_velocity = velocity_clockwise
	# get HealthBar node
	healthbar = get_tree().current_scene.get_node("UI/HUD/HealthBar")

func _physics_process(_delta):
	# If asteroid goes off the bottom of the screen, destroy it
	if position.y > OFF_SCREEN:
		queue_free()

# Called when body_entered signal is emmited
func _on_AsteroidTop_body_entered(body):
	# Instantiate Explosion node
	var explosion = explosion_scene.instance()
	# set explosion's initial position to be the same as Asteroid's current position
	explosion.global_position = global_position
	# set explosion colour to be same as asteroid's
	explosion.process_material.color = explosion_color
	# explosion particles are now emitting
	explosion.emitting = true
	# get World node
	var world = get_tree().current_scene.get_node("World")
	# add child of World node (so it is a sibling to Asteroid)
	world.add_child(explosion)

	
	# If asteroid collided with player, decrease value of HealthBar by 20
	if body.name == "Player":
		healthbar.value -= 20
	
	# If asteroid collides with PlayerBullet
	else:
		# Instantiate AsteroidPiece1 node
		var piece1 = piece1_scene.instance()
		# Set piece1's initial position
		piece1.position.x = position.x - PIECE_POSITION_VARIABILITY
		piece1.position.y = position.y
		piece1.set_linear_velocity(velocity_linear + Vector2(rand_range(-150, -50), 0))
		piece1.get_node("Sprite").scale = scale_vector
		piece1.get_node("CollisionPolygon2D").scale = scale_vector
		# Add child of world node (so it is a sibling to AsteroidTop)
		world.call_deferred("add_child", piece1)

		# Instantiate AsteroidPiece2 node
		var piece2 = piece2_scene.instance()
		# Set piece1's initial position
		piece2.position.x = position.x
		piece2.position.y = position.y + PIECE_POSITION_VARIABILITY
		piece2.set_linear_velocity(velocity_linear + Vector2(rand_range(-50, 50), 0))
		piece2.get_node("Sprite").scale = scale_vector
		piece2.get_node("CollisionPolygon2D").scale = scale_vector
		# Add child of world node (so it is a sibling to AsteroidTop)
		world.call_deferred("add_child", piece2)

		# Instantiate AsteroidPiece3 node
		var piece3 = piece3_scene.instance()
		# Set piece1's initial position
		piece3.position.x = position.x + PIECE_POSITION_VARIABILITY
		piece3.position.y = position.y
		piece3.set_linear_velocity(velocity_linear + Vector2(rand_range(50, 150), 0))
		piece3.get_node("Sprite").scale = scale_vector
		piece3.get_node("CollisionPolygon2D").scale = scale_vector
		# Add child of world node (so it is a sibling to AsteroidTop)
		world.call_deferred("add_child", piece3)
	
	# Remove Asteroid and all its children from the queue
	queue_free()
