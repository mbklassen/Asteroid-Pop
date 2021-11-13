extends Node

const SPEED = 200

var enemy1

func _ready():
	enemy1 = get_parent().get_parent()
	enemy1.linear_velocity = Vector2(0, SPEED)
