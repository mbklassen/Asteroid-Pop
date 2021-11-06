extends RigidBody2D


# the asteroids are given variable velocities
var velocity_linear = Vector2(0, rand_range(100,300))
var velocity_counterclockwise = rand_range(-4,-1)
var velocity_clockwise = rand_range(1,4)
# will dictate the spin direction, depending on the number that rand_range() returns (< 5 versus >= 5)
var rotation_direction = rand_range(0,10)
# will dictate the factor by which the asteroid will be scaled
var scale_factor = rand_range(1,1.8)
var scale_vector = Vector2(scale_factor, scale_factor)
# load explosion particles node
# var piece1_scene = load("res://Scenes/AsteroidPiece1.tscn")
# var piece2_scene = load("res://Scenes/AsteroidPiece2.tscn")
# var piece3_scene = load("res://Scenes/AsteroidPiece3.tscn")

var healthbar

func _ready():
	get_node("Sprite").scale = scale_vector
	get_node("CollisionShape2D").scale = scale_vector
	# set downward speed of asteroid
	linear_velocity = velocity_linear
	# set rotation speed and direction
	if (rotation_direction < 5):
		angular_velocity = velocity_counterclockwise
	else:
		angular_velocity = velocity_clockwise
	# get HealthBar node
#	healthbar = get_parent().get_node("UI/HUD/HealthBar")

func _physics_process(_delta):
	# if asteroid goes off the bottom of the screen, destroy it
	if position.y > 652:
		queue_free()

# Called when body_entered signal is emmited
func _on_Asteroid1_body_entered(body):
	# instantiate Explosion node
	# var explosion = explosion_scene.instance()
	# get parent of current node (World) and store it in level_root
#	var root = get_parent()
#	# add child of parent node (so it is a sibling to Asteroid)
#	root.add_child(explosion)
#	# set explosion's initial position to be the same as Asteroid's current position
#	explosion.position = position
#	# set explosion colour to be same as asteroid's
#	explosion.process_material.color = Color(0.42, 0.31, 0.12, 1)
#	# explosion particles are now emitting
#	explosion.emitting = true
	
	# don't want asteroid to explode into pieces when it hits the player
#	if body.name != "Player":
#		# instantiate AsteroidPiece1 node
#		var piece1 = piece1_scene.instance()
#		# add child of parent node (so it is a sibling to Asteroid)
#		root.call_deferred("add_child", piece1)
#		# set piece1's initial position
#		piece1.position.x = position.x - 16
#		piece1.position.y = position.y
#		piece1.set_linear_velocity(velocity_linear + Vector2(rand_range(-150, -50), 0))
#		piece1.get_node("Sprite").scale = scale_vector
#		piece1.get_node("CollisionShape2D").scale = scale_vector
#
#		# instantiate AsteroidPiece2 node
#		var piece2 = piece2_scene.instance()
#		# add child of parent node (so it is a sibling to Asteroid)
#		root.call_deferred("add_child", piece2)
#		# set piece1's initial position
#		piece2.position.x = position.x
#		piece2.position.y = position.y + 16
#		piece2.set_linear_velocity(velocity_linear + Vector2(rand_range(-50, 50), 0))
#		piece2.get_node("Sprite").scale = scale_vector
#		piece2.get_node("CollisionShape2D").scale = scale_vector
#
#		# instantiate AsteroidPiece3 node
#		var piece3 = piece3_scene.instance()
#		# add child of parent node (so it is a sibling to Asteroid)
#		root.call_deferred("add_child", piece3)
#		# set piece1's initial position
#		piece3.position.x = position.x + 16
#		piece3.position.y = position.y
#		piece3.set_linear_velocity(velocity_linear + Vector2(rand_range(50, 150), 0))
#		piece3.get_node("Sprite").scale = scale_vector
#		piece3.get_node("CollisionShape2D").scale = scale_vector
	
	# if the object the asterioid collided with is the player, decrease value of HealthBar by 20
	if body.name == "Player":
		#healthbar.value -= 20
		print("player hit")
	# destroy the asteroid
	queue_free()
