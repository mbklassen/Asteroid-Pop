extends RigidBody2D

const BULLET_SPEED = 700
const HP_VALUE = 10
const OFF_SCREEN = 690


func _ready():
	# Set direction equal to the normalized vector between boss bullet and player
	var direction = (Global.player_position - global_position).normalized()
	linear_velocity = direction * BULLET_SPEED
	# Set rotation of boss bullet to be relative to direction of movement
	rotation_degrees = -direction.x * 90

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
