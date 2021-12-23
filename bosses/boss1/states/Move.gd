extends Node


const BOSS_STOP_POSITION = 100

var initial_velocity = Vector2(0, 80)
var boss_holding = false

var collision

onready var boss = get_parent().get_parent()

func _physics_process(delta):
	if !boss_holding:
		collision = boss.move_and_collide(initial_velocity * delta)
		if boss.global_position.y >= BOSS_STOP_POSITION:
			boss_holding = true
	else:
		collision = boss.move_and_collide(Vector2.ZERO)
	
	if collision and collision.collider.name == "Player":
		Global.hp = 0

