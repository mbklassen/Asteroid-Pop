extends Node

const BULLET_SPEED = 0.3
const FASTER_BULLET_SPEED = 0.15
const FASTER_SHOOT_DURATION = 10

var bullet_scene = preload("res://player/bullet/PlayerBullet.tscn")
var can_shoot = true
var shooting_faster = false

var timer1
var timer2
var firing_positions
var item_shoot_faster

func _ready():
	
	timer1 = $TimeBetweenShots
	timer1.wait_time = BULLET_SPEED
	
	timer2 = $ShootFasterTimer
	timer2.wait_time = FASTER_SHOOT_DURATION
	
	# Get FiringPositions node (^States -> ^Player -> FiringPositions)
	firing_positions = get_parent().get_parent().get_node("FiringPositions")
	
	
func _physics_process(_delta):
	if Input.is_action_pressed("shoot") and can_shoot:
		# Create a bullet at each firing position (add it as a child of the Level node)
		for child in firing_positions.get_children():
			var bullet = bullet_scene.instance()
			bullet.global_position = child.global_position
			# Get level node (^States -> ^Player -> ^LevelX)
			var level_node = get_parent().get_parent().get_parent()
			# Instantiate PlayerBullet node 
			level_node.add_child(bullet)
		# Player can no longer shoot, start timer
		can_shoot = false
		if Global.item_shoot_faster_acquired:
			Global.item_shoot_faster_acquired = false
			if !timer2.is_stopped():
				timer2.stop()
			timer2.start()
			timer1.wait_time = FASTER_BULLET_SPEED
		timer1.start()


func _on_TimeBetweenShots_timeout():
	can_shoot = true
	
func _on_ShootFasterTimer_timeout():
	timer1.wait_time = BULLET_SPEED
