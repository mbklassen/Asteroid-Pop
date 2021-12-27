extends Node


const BOSS_HP_THRESHOLD = 120

var lockon_bullet_scene = preload("res://bosses/boss1/bullet/Boss1LockOnBullet.tscn")
var left_bullet_scene = preload("res://bosses/boss1/bullet/Boss1LeftBullet.tscn")
var right_bullet_scene = preload("res://bosses/boss1/bullet/Boss1RightBullet.tscn")
var straight_bullet_scene = preload("res://bosses/boss1/bullet/Boss1StraightBullet.tscn")
var can_shoot = true
var super_mode = false
var can_shoot_all = false

var time_between_shots
var time_between_shots_super
var firing_positions
var firing_side
var boss_holding_y

func _ready():
	time_between_shots = $TimeBetweenShots1
	time_between_shots.wait_time = rand_range(0.5, 2)
	time_between_shots_super = $TimeBetweenShots2
	time_between_shots_super.wait_time = rand_range(0.5, 2)
	firing_positions = get_parent().get_parent().get_node("FiringPositions")

func _physics_process(_delta):
	firing_side = rand_range(0, 1)
	boss_holding_y = get_parent().get_node("Move").boss_holding_y
	
	if !super_mode and can_shoot and boss_holding_y and firing_side < 0.5:
		can_shoot = false
		if time_between_shots.is_stopped():
			time_between_shots.start()
		for child in firing_positions.get_children():
			if child.name == "LeftFrontGun":
				var lockon_bullet = lockon_bullet_scene.instance()
				lockon_bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(lockon_bullet)
	
	if !super_mode and can_shoot and boss_holding_y and firing_side >= 0.5:
		can_shoot = false
		if time_between_shots.is_stopped():
			time_between_shots.start()
		for child in firing_positions.get_children():
			if child.name == "RightFrontGun":
				var lockon_bullet = lockon_bullet_scene.instance()
				lockon_bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(lockon_bullet)
				
	if Global.boss1_hp <= BOSS_HP_THRESHOLD and !super_mode:
		super_mode = true
		can_shoot_all = true
		
	if super_mode and can_shoot_all and boss_holding_y:
		can_shoot_all = false
		if time_between_shots_super.is_stopped():
			time_between_shots_super.start()
		for child in firing_positions.get_children():
			if child.name == "LeftFrontGun":
				var bullet = straight_bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
			if child.name == "RightFrontGun":
				var bullet = straight_bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
			if child.name == "LeftSideGun":
				var bullet = left_bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
			if child.name == "RightSideGun":
				var bullet = right_bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
	
func _on_TimeBetweenShots1_timeout():
	can_shoot = true
	time_between_shots.wait_time = rand_range(0.5, 2)
	time_between_shots.start()

func _on_TimeBetweenShots2_timeout():
	can_shoot_all = true
	time_between_shots_super.wait_time = rand_range(0.5, 2)
	time_between_shots_super.start()
