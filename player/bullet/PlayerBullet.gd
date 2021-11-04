extends RigidBody2D

const BULLET_SPEED = 800

func _ready():
	linear_velocity = Vector2(0, -BULLET_SPEED)
