extends Node

const ACCELERATION = 500
const MAX_SPEED = 120
const FRICTION = 250

const HOLD_POSITION = 120
const MOVEMENT_BUFFER = 45

var thruster_small_scene = preload("res://particles/BossThrusterSmall.tscn")
var thruster_big_scene = preload("res://particles/BossThrusterBig.tscn")

var motion = Vector2.ZERO
var y_speed = Vector2.ZERO
# Initial velocity of boss when entering the screen (constant speed downward)
var initial_velocity = Vector2(0, 80)
var boss_holding_y = false
var moving_right = true
var moving_left = false

var boss
var direction
var collision
var thruster_left_position
var thruster_right_position
var thruster_center_position
var thruster_left
var thruster_right
var thruster_center

func _ready():
	# Get boss node
	boss = get_parent().get_parent()
	# Get thruster positions
	thruster_left_position = boss.get_node("ThrusterPositions/LeftThruster")
	thruster_right_position = boss.get_node("ThrusterPositions/RightThruster")
	thruster_center_position = boss.get_node("ThrusterPositions/CenterThruster")
	
	# Instantiate Thruster nodes
	thruster_left = thruster_small_scene.instance()
	thruster_right = thruster_small_scene.instance()
	thruster_center = thruster_big_scene.instance()
	# Explosion particles are now emitting
	thruster_left.emitting = false
	thruster_right.emitting = false
	thruster_center.emitting = false
	# Add thrusters as children of boss node
	boss.call_deferred("add_child", thruster_left)
	boss.call_deferred("add_child", thruster_right)
	boss.call_deferred("add_child", thruster_center)

func _physics_process(delta):
	# If boss is not holding y-position
	if !boss_holding_y:
		# then move boss at a constant velocity (in this case, downward)
		y_speed = boss.move_and_slide(initial_velocity)
		# If boss's y-position equals or exceeds HOLD_POSITION and boss is not yet holding y-position
		# then boss is now stopped (holding) at current position
		if boss.global_position.y >= HOLD_POSITION and !boss_holding_y:
			boss_holding_y = true
	# Else if boss is holding y-position
	else:
		# then y_speed = (0, 0)
		y_speed = Vector2.ZERO
		# If boss's x-position is greater than the player's x-position + MOVEMENT_BUFFER
		# then boss is moving left and not moving right
		# (MOVEMENT_BUFFER allows player to move a little bit within a range and not have the boss move)
		# (MOVEMENT_BUFFER also prevents boss ship from glitching into edge of screen when player ship moves to the edge)
		if boss.global_position.x > Global.player_position.x + MOVEMENT_BUFFER:
			moving_right = false
			moving_left = true
		# If boss's x-position is less than the player's x-position - MOVEMENT_BUFFER
		# then boss is moving right and not moving left
		elif boss.global_position.x < Global.player_position.x - MOVEMENT_BUFFER:
			moving_right = true
			moving_left = false
		# If boss's x-position is less than or equal to MOVEMENT_BUFFER-distance-away from the player's x-position
		# then boss is not moving
		elif boss.global_position.x <= Global.player_position.x + MOVEMENT_BUFFER and boss.global_position.x >= Global.player_position.x - MOVEMENT_BUFFER:
			moving_left = false
			moving_right = false
		
		# Set the boss's direction vectors
		if moving_right:
			direction = Vector2(1, 0)
		elif moving_left:
			direction = Vector2(-1, 0)
		elif !moving_left and !moving_right:
			direction = Vector2.ZERO
		
		# If boss is about to stop moving (decelerating) or is stopped
		if direction.x == 0 or Global.boss1_super_mode:
			# The instantaneous deceleration due to friction is equal to FRICTION constant multiplied by delta
			var friction = FRICTION * delta
			# Apply friction when the length of the boss's motion vector is greater than length of friction
			# In other words, so long as boss is moving faster than friction value, then apply friction
			# Friction is applied in the opposite direction from the boss's motion
			if motion.length() > friction:
				motion -= motion.normalized() * friction
			# Else if boss is moving slower than the friction value, set the boss's motion vector to zero
			else:
				motion = Vector2.ZERO
		# Else if boss is not stopped and not about to stop (not decelerating)
		else:
			# Use direction vector (determined above), ACCELERATION constant, and delta to find instantaneous acceleration
			var acceleration = direction * ACCELERATION * delta
			# Add instantaneous acceleration to the boss's motion vector
			motion += acceleration
			# Limits motion vector (can be no greater than MAX_SPEED)
			motion = motion.clamped(MAX_SPEED)
		
		# Move boss in accordance with the current value of motion vector
		motion = boss.move_and_slide(motion)
	
	# Set positions of boss's thrusters
	thruster_left.global_position = thruster_left_position.global_position
	thruster_right.global_position = thruster_right_position.global_position
	thruster_center.global_position = thruster_center_position.global_position
	# If boss is not moving downward, thrusters are not emitting
	if y_speed == Vector2.ZERO:
		thruster_left.emitting = false
		thruster_right.emitting = false
		thruster_center.emitting = false
	# Else all three thrusters are emitting
	else:
		thruster_left.emitting = true
		thruster_right.emitting = true
		thruster_center.emitting = true
	# Additionally, if boss is moving horizontally then wing thrusters are emitting
	if motion != Vector2.ZERO:
		thruster_left.emitting = true
		thruster_right.emitting = true
