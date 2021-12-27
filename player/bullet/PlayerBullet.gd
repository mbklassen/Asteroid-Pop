extends RigidBody2D

const BULLET_SPEED = 800
const OFF_SCREEN = -50

func _ready(): 
	# Set bullet linear velocity
	linear_velocity = Vector2(0, -BULLET_SPEED)
	
func _physics_process(_delta):
	# If bullet goes off the top of the screen, queue it to be freed
	if position.y < OFF_SCREEN:
		queue_free()


func _on_PlayerBullet_body_entered(body):
	# If the object the bullets collided with is an enemy, increase score by 1
	if body.is_in_group("asteroids"):
		Global.score += 1
	elif body.is_in_group("enemy-type1"):
		Global.score += 3
	elif body.is_in_group("bosses"):
		Global.boss1_hp -= 2
	# Queue the bullet to be freed
	queue_free()
