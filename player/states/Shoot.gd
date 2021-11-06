extends Node

var bullet_scene = preload("res://player/bullet/PlayerBullet.tscn")
var can_shoot = true

var timer
var firing_positions

func _ready():
	timer = get_node("TimeBetweenShots")
	timer.wait_time = 0.2
	
	# get FiringPositions node (Shoot -> States -> FiringPositions)
	firing_positions = get_parent().get_parent().get_node("FiringPositions")
	
func _physics_process(_delta):
	if Input.is_action_pressed("shoot") and can_shoot:
		# instantiate PlayerBullets node 
		# create a bullet at each firing position (add it as a child of the World scene)
		for child in firing_positions.get_children():
			var bullet = bullet_scene.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.get_node("World").add_child(bullet)
		# player can no longer shoot, start timer
		can_shoot = false
		timer.start()

# when timer runs out, player can shoot again
func _on_TimeBetweenShots_timeout():
	can_shoot = true
