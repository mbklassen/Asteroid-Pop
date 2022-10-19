extends Node

const ACCELERATION = 2400
const MAX_SPEED = 400
const FRICTION = 2400

var thruster_scene = preload("res://particles/PlayerThruster.tscn")
var velocity = Vector2.ZERO
var motion = Vector2.ZERO

# Get player node
var player
var thruster_position
var thruster

func _ready():
	player = get_parent().get_parent()
	thruster_position = player.get_node("ThrusterPosition")
	# Instantiate Thruster node
	thruster = thruster_scene.instance()
	# Explosion particles are now emitting
	thruster.emitting = false
	# Add thruster as a child of player node
	player.call_deferred("add_child", thruster)

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	# Get input_vector based on the which movement buttons are being pressed or which way the joystick is tilted
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	# If there is no direction being input
	if input_vector == Vector2.ZERO:
		var amount = FRICTION * delta
		# Apply friction when the player's motion vector is greater than FRICTION * delta
		if motion.length() > amount:
			motion -= motion.normalized() * amount
		# Else, set the player's speed to zero
		else:
			motion = Vector2.ZERO
		
	# Else if a direction is being input, accelerate player up to a max speed
	else:
		var acceleration = input_vector * ACCELERATION * delta
		motion += acceleration
		motion = motion.limit_length(MAX_SPEED)
	
	motion = player.move_and_slide(motion)
	
	# Player's thruster emits when moving, else it does not
	thruster.global_position = thruster_position.global_position
	if motion == Vector2.ZERO:
		thruster.emitting = false
	else:
		thruster.emitting = true
