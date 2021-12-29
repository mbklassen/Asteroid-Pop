extends Node

const ACCELERATION = 500
const MAX_SPEED = 120
const FRICTION = 250

const HOLD_POSITION = 120
const MOVEMENT_BUFFER = 45

var motion = Vector2.ZERO
var initial_velocity = Vector2(0, 80)
var boss_holding_y = false
var moving_right = true
var moving_left = false

var boss
var direction
var collision
var hit_effect_timer

func _ready():
	boss = get_parent().get_parent()
	hit_effect_timer = $HitEffectTimer

func _physics_process(delta):
	if !boss_holding_y:
		collision = boss.move_and_collide(initial_velocity * delta)
		if boss.global_position.y >= HOLD_POSITION and !boss_holding_y:
			boss_holding_y = true
	else:
		
		if boss.global_position.x >= Global.player_position.x + MOVEMENT_BUFFER:
			moving_right = false
			moving_left = true
		elif boss.global_position.x <= Global.player_position.x - MOVEMENT_BUFFER:
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
			
		collision = boss.move_and_collide(motion * delta)
		
	if collision != null and collision.collider.is_in_group("player_bullets"):
		print ("boss was hit")
		boss.modulate = Color(2, 2, 2, 1)
		hit_effect_timer.wait_time = 0.3
		hit_effect_timer.start()
		

func _on_HitEffectTimer_timeout():
	boss.modulate = Color(1, 1, 1, 1)
