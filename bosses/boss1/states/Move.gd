extends Node


const BOSS_HOLD_POSITION = 100

var initial_velocity = Vector2(0, 80)
var boss_holding_y = false
var moving_right = true

onready var boss = get_parent().get_parent()
onready var raycast_right = get_parent().get_parent().get_node("RayCastRight")
onready var raycast_left = get_parent().get_parent().get_node("RayCastLeft")

var collision

func _physics_process(delta):
	if !boss_holding_y:
		collision = boss.move_and_collide(initial_velocity * delta)
		if boss.global_position.y >= BOSS_HOLD_POSITION:
			boss_holding_y = true
	else:
		if !raycast_right.enabled and !raycast_left.enabled:
			raycast_right.enabled = true
			raycast_left.enabled = true
			
		if raycast_right.is_colliding():
			moving_right = false
		elif raycast_left.is_colliding():
			moving_right = true
		
		if moving_right:
			collision = boss.move_and_collide(Vector2(80, 0) * delta)
		else:
			collision = boss.move_and_collide(Vector2(-80, 0) * delta)
	
	if collision and collision.collider.name == "Player":
		Global.hp = 0


