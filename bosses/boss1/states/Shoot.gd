extends Node


const BOSS_HP_THRESHOLD = 300

var bullet_scene = preload("res://bosses/boss1/bullets/Boss1Bullet.tscn")
var super_shots_left = 3
var boss_ready = false
var can_shoot = false
var can_shoot_all = false
var super_effect_repeated = false
var super_effect_color = Color(1.9, 1.9, 1.9)
var normal_color = Color(1.5, 1.5, 1.5)

var time_between_shots
var time_between_super
var time_between_shots_super
var super_effect_off_timer
var super_effect_on_timer

var boss
var boss_sprite
var firing_positions
var firing_side
var boss_holding_y

signal bullet_type_lockon
signal bullet_type_straight
signal bullet_type_ld
signal bullet_type_rd
signal bullet_type_lds
signal bullet_type_rds

func _ready():
	time_between_shots = $TimeBetweenShots
	time_between_shots.wait_time = 1
	time_between_super = $TimeBetweenSuper
	time_between_super.wait_time = rand_range(6, 10)
	time_between_shots_super = $TimeBetweenShotsSuper
	super_effect_off_timer = $SuperEffectOff
	super_effect_on_timer = $SuperEffectOn
	
	boss = get_parent().get_parent()
	boss_sprite = boss.get_node("Sprite")
	firing_positions = get_parent().get_parent().get_node("FiringPositions")

func _physics_process(_delta):
	firing_side = rand_range(0, 1)
	if !boss_holding_y:
		boss_holding_y = get_parent().get_node("Move").boss_holding_y
	
	if time_between_shots.is_stopped() and time_between_super.is_stopped() and boss_holding_y and !boss_ready:
		boss_ready = true
		time_between_shots.start()
		time_between_super.start()
	
	if can_shoot and boss_holding_y and firing_side < 0.5:
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
	
	if can_shoot and boss_holding_y and firing_side >= 0.5:
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
				
		
	if can_shoot_all and boss_holding_y:
		can_shoot_all = false
		for child in firing_positions.get_children():
			if child.name == "LeftFrontGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
				emit_signal("bullet_type_ld")
			if child.name == "RightFrontGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
				emit_signal("bullet_type_rd")
			if child.name == "LeftSideGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
				emit_signal("bullet_type_lds")
			if child.name == "RightSideGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
				emit_signal("bullet_type_rds")
			if child.name == "CenterGun":
				var bullet = bullet_scene.instance()
				bullet.global_position = child.global_position
				# Get level node (^States -> ^Player -> ^LevelX)
				var level_node = get_parent().get_parent().get_parent()
				# Instantiate Boss1Bullet node 
				level_node.add_child(bullet)
				emit_signal("bullet_type_straight")

func _on_TimeBetweenShots_timeout():
	can_shoot = true
	time_between_shots.wait_time = rand_range(0.5, 1.5)
	time_between_shots.start()
	
func _on_TimeBetweenSuper_timeout():
	super_shots_left = 3
	can_shoot = false
	time_between_shots.stop()
	
	boss_sprite.self_modulate = super_effect_color
	super_effect_off_timer.wait_time = 0.3
	super_effect_off_timer.start()

func _on_SuperEffectOff_timeout():
	boss_sprite.self_modulate = normal_color
	if !super_effect_repeated:
		super_effect_repeated = true
		super_effect_on_timer.wait_time = 0.3
		super_effect_on_timer.start()
	else:
		super_effect_repeated = false
		time_between_shots_super.wait_time = 0.5
		time_between_shots_super.start()

func _on_SuperEffectOn_timeout():
	boss_sprite.self_modulate = super_effect_color
	super_effect_off_timer.wait_time = 0.3
	super_effect_off_timer.start()

func _on_TimeBetweenShotsSuper_timeout():
	if super_shots_left > 0:
		super_shots_left -= 1
		can_shoot_all = true
		Global.boss1_super_mode = true
		time_between_shots_super.wait_time = 0.5
		time_between_shots_super.start()
	else:
		can_shoot_all = false
		Global.boss1_super_mode = false
		time_between_shots.wait_time = 1
		time_between_shots.start()
		time_between_super.wait_time = rand_range(4, 10)
		time_between_super.start()
