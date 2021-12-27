extends RigidBody2D


const BULLET_SPEED = 600
const HP_VALUE = 10
const OFF_SCREEN = 690


func _ready():
	linear_velocity = Vector2(0, BULLET_SPEED)

func _physics_process(_delta):
	# If bullet goes off the bottom of the screen, queue it to be freed
	if global_position.y > OFF_SCREEN:
		queue_free()

func _on_Boss1Bullet_body_entered(body):
	# If the object the bullet collided with is the player, decrease value of health bar
	if body.name == "Player":
		Global.hp -= HP_VALUE
	# Queue bullet to be freed
	queue_free()
