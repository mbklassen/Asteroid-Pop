extends RigidBody2D

const BULLET_SPEED = 800

func _ready(): 
	# set bullet linear velocity
	linear_velocity = Vector2(0, -BULLET_SPEED)
	
func _physics_process(_delta):
	# if bullet goes off the top of the screen, destroy it
	if position.y < -16:
		queue_free()
