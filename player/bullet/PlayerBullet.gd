extends RigidBody2D

const BULLET_SPEED = 800
const OFF_SCREEN = -50

func _ready(): 
	# Set bullet linear velocity
	linear_velocity = Vector2(0, -BULLET_SPEED)
	
func _physics_process(_delta):
	# If bullet goes off the top of the screen, destroy it
	if position.y < OFF_SCREEN:
		queue_free()


func _on_PlayerBullet_body_entered(body):
	# If the object the bullets collided with is an enemy, increase score by 1
	if body.is_in_group("asteroids"):
		Global.score += 1
#	elif body.is_in_group("ENEMY_1"):
#		Global.score += 3
#	# Destroy the bullets
	queue_free()
