extends Node


var bullet_scene = preload("res://enemies/enemy1/bullet/Enemy1Bullet.tscn")
var can_shoot = true

var timer

func _ready():
	timer = $TimeBetweenShots

func _physics_process(_delta):
	if can_shoot:
		can_shoot = false
		var bullet = bullet_scene.instance()
		# Get level node
		var level_node = get_parent().get_parent().get_parent()
		var firing_position = get_parent().get_parent().get_node("FiringPosition")
		bullet.global_position = firing_position.global_position
		# Add child of parent node (so it is a sibling to Enemy1)
		level_node.add_child(bullet)
		# If timer stops, start it again
		if (timer.is_stopped()):
			timer.wait_time = rand_range(2, 4)
			timer.start()
	
func _on_TimeBetweenShots_timeout():
	can_shoot = true
