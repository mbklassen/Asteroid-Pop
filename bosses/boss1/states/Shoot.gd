extends Node


var bullet_scene = preload("res://bosses/boss1/bullet/Boss1Bullet.tscn")
var can_shoot = false

var timer1
var firing_positions
var firing_side
var boss_holding_y

func _ready():
	timer1 = $TimeBetweenShots1
	
	firing_positions = get_parent().get_parent().get_node("FiringPositions")

func _physics_process(_delta):
	firing_side = rand_range(0, 1)
	boss_holding_y = get_parent().get_node("Move").boss_holding_y
	if can_shoot and boss_holding_y and firing_side < 0.5:
		can_shoot = false
		for child in firing_positions.get_children():
			if child.name == "LeftFrontGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate PlayerBullet node 
				level_node.add_child(bullet)
	
	if can_shoot and boss_holding_y and firing_side >= 0.5:
		can_shoot = false
		for child in firing_positions.get_children():
			if child.name == "RightFrontGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate PlayerBullet node 
				level_node.add_child(bullet)
				
	# If timer stops, start it again
	if (timer1.is_stopped()):
		timer1.wait_time = rand_range(0.5, 2)
		timer1.start()
	
func _on_TimeBetweenShots1_timeout():
	can_shoot = true
