extends RigidBody2D

const ROTATION_DIRECTION_SWITCH = 0.5
const OFF_SCREEN_BOTTOM = 652
const OFF_SCREEN_TOP = -40
const HP_VALUE = 10

var velocity_counterclockwise = rand_range(-4, -1)
var velocity_clockwise = rand_range(1, 4)
# Will dictate the spin direction, depending on the number that rand_range() returns (< 0.5 versus >= 0.5)
var rotation_direction = rand_range(0, 1)

func _ready():
	# Set rotation speed and direction
	if (rotation_direction < ROTATION_DIRECTION_SWITCH):
		angular_velocity = velocity_counterclockwise
	else:
		angular_velocity = velocity_clockwise

func _physics_process(_delta):
	# If asteroid goes off the bottom of the screen, destroy it
	if position.y > OFF_SCREEN_BOTTOM or position.y < OFF_SCREEN_TOP:
		queue_free()

# Called when body_entered signal is emitted
# On collision with another object
func _on_AsteroidPiece_body_entered(body):
	# If asteroid piece collided with player, decrease value of health bar
	if body.name == "Player":
		Global.hp -= HP_VALUE
	# Destroy the asteroid piece
	queue_free()
