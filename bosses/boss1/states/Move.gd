extends Node

const ACCELERATION = 700
const MAX_SPEED = 120
const FRICTION = 300

const HOLD_POSITION = 120
const MOVEMENT_BUFFER = 40

var motion = Vector2.ZERO
var initial_velocity = Vector2(0, 80)
var boss_holding_y = false
var moving_right = true
var moving_left = false

var boss
var raycast_right
var raycast_left
var direction
var collision

func _ready():
	boss = get_parent().get_parent()
	raycast_right = get_parent().get_parent().get_node("RayCastRight")
	raycast_left = get_parent().get_parent().get_node("RayCastLeft")

func _physics_process(delta):
	if !boss_holding_y:
		collision = boss.move_and_collide(initial_velocity * delta)
		if boss.global_position.y >= HOLD_POSITION and !boss_holding_y:
			boss_holding_y = true
	else:
		if !raycast_right.enabled and !raycast_left.enabled:
			raycast_right.enabled = true
			raycast_left.enabled = true
		
		if (raycast_right.is_colliding()) or (boss.global_position.x >= Global.player_position.x + MOVEMENT_BUFFER and !raycast_left.is_colliding()):
			moving_right = false
			moving_left = true
		elif (raycast_left.is_colliding()) or (boss.global_position.x <= Global.player_position.x - MOVEMENT_BUFFER and !raycast_right.is_colliding()):
			moving_right = true
			moving_left = false
		elif boss.global_position.x < Global.player_position.x + MOVEMENT_BUFFER and boss.global_position.x > Global.player_position.x - MOVEMENT_BUFFER:
			moving_left = false
			moving_right = false
			
		if moving_right:
			direction = Vector2(1, 0)
		elif moving_left:
			direction = Vector2(-1, 0)
		elif !moving_left and !moving_right:
			direction = Vector2.ZERO
			
		if direction.x == 0:
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
