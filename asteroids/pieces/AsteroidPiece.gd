extends RigidBody2D

const ROTATION_DIRECTION_SWITCH = 1
const OFF_SCREEN_BOTTOM = 652
const OFF_SCREEN_TOP = -40

var velocity_counterclockwise = rand_range(-4, -1)
var velocity_clockwise = rand_range(1, 4)
# Will dictate the spin direction, depending on the number that rand_range() returns (< 5 versus >= 5)
var rotation_direction = rand_range(0, 2)

#var healthbar

func _ready():
	# Set rotation speed and direction
	if (rotation_direction < ROTATION_DIRECTION_SWITCH):
		angular_velocity = velocity_counterclockwise
	else:
		angular_velocity = velocity_clockwise
	# Get HealthBar node
#	healthbar = get_tree().current_scene.get_node("UI/HUD/HealthBar")

func _physics_process(_delta):
	# If asteroid goes off the bottom of the screen, destroy it
	if position.y > OFF_SCREEN_BOTTOM or position.y < OFF_SCREEN_TOP:
		queue_free()

func _on_AsteroidPiece_body_entered(body):
	if body.name == "Player":
		Global.hp -= 10
	# Destroy the asteroid
	queue_free()
