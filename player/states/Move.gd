extends Node

const ACCELERATION = 1300
const MAX_SPEED = 400
const FRICTION = 600

var velocity = Vector2.ZERO
var motion = Vector2.ZERO

# Get player node
onready var player = get_parent().get_parent()

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	# Get input_vector based on the which movement buttons are being pressed or which way the joystick is tilted
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	# If there is no direction being input
	if input_vector == Vector2.ZERO:
		var amount = FRICTION * delta
		# Apply friction when the player's speed is greater than FRICTION * delta
		if motion.length() > amount:
			motion -= motion.normalized() * amount
		# Else, set the player's speed to zero
		else:
			motion = Vector2.ZERO
		
	# Else if a direction is being input, accelerate player up to a max speed
	else:
		var acceleration = input_vector * ACCELERATION * delta
		motion += acceleration
		motion = motion.clamped(MAX_SPEED)
	
	motion = player.move_and_slide(motion)
