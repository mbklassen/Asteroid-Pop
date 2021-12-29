extends Node


const BOSS_HP_THRESHOLD = 150

var bullet_scene = preload("res://bosses/boss1/bullets/Boss1Bullet.tscn")
var can_shoot = false
var super_mode = false
var can_shoot_all = false

var time_between_shots
var time_between_shots_super
var firing_positions
var firing_side
var boss_holding_y

signal bullet_type_lockon
signal bullet_type_straight
signal bullet_type_ld
signal bullet_type_rd

func _ready():
	time_between_shots = $TimeBetweenShots1
	time_between_shots.wait_time = 1
	time_between_shots_super = $TimeBetweenShots2
	time_between_shots_super.wait_time = 1
	firing_positions = get_parent().get_parent().get_node("FiringPositions")

func _physics_process(_delta):
	firing_side = rand_range(0, 1)
	boss_holding_y = get_parent().get_node("Move").boss_holding_y
	
	if time_between_shots.is_stopped() and boss_holding_y:
		time_between_shots.start()
	
	if time_between_shots_super.is_stopped() and super_mode:
		time_between_shots_super.start()
	
	if !super_mode and can_shoot and boss_holding_y and firing_side < 0.5:
		can_shoot = false
		for child in firing_positions.get_children():
			if child.name == "LeftFrontGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
				emit_signal("bullet_type_lockon")
	
	if !super_mode and can_shoot and boss_holding_y and firing_side >= 0.5:
		can_shoot = false
		for child in firing_positions.get_children():
			if child.name == "RightFrontGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
				emit_signal("bullet_type_lockon")
				
	if Global.boss1_hp <= BOSS_HP_THRESHOLD and !super_mode:
		super_mode = true
		
	if super_mode and can_shoot_all and boss_holding_y:
		can_shoot_all = false
		for child in firing_positions.get_children():
			if child.name == "LeftFrontGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
				emit_signal("bullet_type_straight")
			if child.name == "RightFrontGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
				emit_signal("bullet_type_straight")
			if child.name == "LeftSideGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
				emit_signal("bullet_type_ld")
			if child.name == "RightSideGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
				emit_signal("bullet_type_rd")
	
func _on_TimeBetweenShots1_timeout():
	can_shoot = true
	time_between_shots.wait_time = rand_range(0.5, 1.5)
	time_between_shots.start()

func _on_TimeBetweenShots2_timeout():
	can_shoot_all = true
	time_between_shots_super.wait_time = rand_range(1, 2.5)
	time_between_shots_super.start()
