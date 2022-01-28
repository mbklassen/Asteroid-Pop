extends Node


var bullet_scene = preload("res://enemies/enemy1/bullet/Enemy1Bullet.tscn")
var shoot_sound_scene = preload("res://sounds/audio-stream-players/Enemy1Shoot.tscn")
var can_shoot = false

var timer
var level_node

func _ready():
	level_node = get_parent().get_parent().get_parent()
	timer = $TimeBetweenShots
	timer.wait_time = rand_range(0.3, 1)
	timer.start()

func _physics_process(_delta):
	if can_shoot:
		var shoot_sound = shoot_sound_scene.instance()
		level_node.add_child(shoot_sound)
		can_shoot = false
		var bullet = bullet_scene.instance()
		var firing_position = get_parent().get_parent().get_node("FiringPosition")
		bullet.global_position = firing_position.global_position
		level_node.add_child(bullet)

# Enemy spawns bullets between delays (the delay can be anywhere from 1.5 to 2.5 seconds)
func _on_TimeBetweenShots_timeout():
	can_shoot = true
	timer.wait_time = rand_range(1.5, 2.5)
	timer.start()
