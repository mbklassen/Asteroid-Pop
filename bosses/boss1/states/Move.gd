extends Node

const ACCELERATION = 500
const MAX_SPEED = 120
const FRICTION = 250

const HOLD_POSITION = 120
const MOVEMENT_BUFFER = 45

var thruster_small_scene = preload("res://particles/BossThrusterSmall.tscn")
var thruster_big_scene = preload("res://particles/BossThrusterBig.tscn")

var motion = Vector2.ZERO
var enter_speed = Vector2.ZERO
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
var thruster_sound

func _ready():
	boss = get_parent().get_parent()
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
	
	thruster_sound = boss.get_node("ThrusterSound")
	thruster_sound.play()

func _physics_process(delta):
	if !boss_holding_y:
		enter_speed = boss.move_and_slide(initial_velocity)
		if boss.global_position.y >= HOLD_POSITION and !boss_holding_y:
			boss_holding_y = true
	else:
		enter_speed = Vector2.ZERO
		if boss.global_position.x > Global.player_position.x + MOVEMENT_BUFFER:
			moving_right = false
			moving_left = true
		elif boss.global_position.x < Global.player_position.x - MOVEMENT_BUFFER:
			moving_right = true
			moving_left = false
		elif boss.global_position.x <= Global.player_position.x + MOVEMENT_BUFFER and boss.global_position.x >= Global.player_position.x - MOVEMENT_BUFFER:
			moving_left = false
			moving_right = false
			
		if moving_right:
			direction = Vector2(1, 0)
		elif moving_left:
			direction = Vector2(-1, 0)
		elif !moving_left and !moving_right:
			direction = Vector2.ZERO
			
		if direction.x == 0 or Global.boss1_super_mode:
			var amount = FRICTION * delta
			# Apply friction when the player's speed is greater than FRICTION * delta
			if motion.length() > amount:
				motion -= motion.normalized() * amount
			# Else, set the player's speed to zero
			else:
				motion = Vector2.ZERO
				
		else:
			var acceleration = direction * ACCELERATION * delta
			motion += acceleration
			motion = motion.clamped(MAX_SPEED)
			
		motion = boss.move_and_slide(motion)
	
	thruster_left.global_position = thruster_left_position.global_position
	thruster_right.global_position = thruster_right_position.global_position
	thruster_center.global_position = thruster_center_position.global_position
	if enter_speed == Vector2.ZERO:
		thruster_left.emitting = false
		thruster_right.emitting = false
		thruster_center.emitting = false
		thruster_sound.stream_paused = true
	else:
		thruster_left.emitting = true
		thruster_right.emitting = true
		thruster_center.emitting = true
		thruster_sound.stream_paused = false
	if motion != Vector2.ZERO:
		thruster_left.emitting = true
		thruster_right.emitting = true
		thruster_sound.stream_paused = false
