extends Node

var bullet_scene = preload("res://player/bullet/PlayerBullet.tscn")
var can_shoot = true

onready var firing_positions = get_parent().get_parent().get_node("FiringPositions")

onready var timer = get_node("TimeBetweenShots")
	
func _physics_process(_delta):
	if Input.is_action_pressed("shoot") and can_shoot:
		# Instantiate PlayerBullets node
		for child in firing_positions.get_children():
			var bullet = bullet_scene.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)
		can_shoot = false
		timer.start()

func _on_TimeBetweenShots_timeout():
	can_shoot = true
