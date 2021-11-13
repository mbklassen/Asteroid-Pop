extends Node

var bullet_scene = preload("res://player/bullet/PlayerBullet.tscn")
var can_shoot = true

var timer
var firing_positions

func _ready():
	
	timer = $TimeBetweenShots
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.wait_time = 0.2
	
	# Get FiringPositions node (Shoot -> States -> FiringPositions)
	firing_positions = get_parent().get_parent().get_node("FiringPositions")
	
	
func _physics_process(_delta):
	if Input.is_action_pressed("shoot") and can_shoot:
		# Create a bullet at each firing position (add it as a child of the Level node)
		for child in firing_positions.get_children():
			var bullet = bullet_scene.instance()
			bullet.global_position = child.global_position
			# Get level node
			var level_node = get_parent().get_parent().get_parent()
			# Instantiate PlayerBullet node 
			level_node.add_child(bullet)
		# Player can no longer shoot, start timer
		can_shoot = false
		timer.start()

# When timer runs out, player can shoot again
func _on_timer_timeout():
	can_shoot = true
