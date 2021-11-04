extends Node


var bullet_scene = load("res://player/bullet/PlayerBullet.tscn")
var can_shoot = true

onready var timer = get_node("TimeBetweenShots")
	
func _process(_delta):
	if Input.is_action_pressed("shoot") and can_shoot:
		# Instantiate PlayerBullets node
		var bullet = bullet_scene.instance()
		add_child(bullet)
		var player = get_parent().get_parent()
		bullet.position = player.position
		bullet.set_linear_velocity()
		can_shoot = false
		timer.start()

func _on_TimeBetweenShots_timeout():
	can_shoot = true
