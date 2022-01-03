extends RigidBody2D


const BULLET_SPEED = 600
const HP_VALUE = 10
const OFF_SCREEN = 690

var bullet_has_shot = false

func _ready():
	var boss_shoot = get_parent().get_node("Boss1/States/Shoot")
	# Connect signals emitted from Boss1/States/Shoot to methods in this class
	boss_shoot.connect("bullet_type_lockon", self, "_on_Shoot_lockon")
	boss_shoot.connect("bullet_type_straight", self, "_on_Shoot_straight")
	boss_shoot.connect("bullet_type_ld", self, "_on_Shoot_ld")
	boss_shoot.connect("bullet_type_rd", self, "_on_Shoot_rd")
	boss_shoot.connect("bullet_type_lds", self, "_on_Shoot_lds")
	boss_shoot.connect("bullet_type_rds", self, "_on_Shoot_rds")
	

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

func _on_Shoot_lockon():
	if !bullet_has_shot:
		# Set direction equal to the normalized vector between boss bullet and player
		var direction = (Global.player_position - global_position).normalized()
		linear_velocity = direction * BULLET_SPEED
		# Set rotation of boss bullet to be relative to direction of movement
		rotation_degrees = -direction.x * 90
		bullet_has_shot = true

func _on_Shoot_straight():
	if !bullet_has_shot:
		# Set linear velocity to be downward at a certain speed
		linear_velocity = Vector2(0, BULLET_SPEED)
		bullet_has_shot = true
		
func _on_Shoot_ld():
	if !bullet_has_shot:
		# Set direction equal to a normalized vector pointing left-down
		var direction = (Vector2(-1,8)).normalized()
		linear_velocity = direction * BULLET_SPEED
		# Set rotation of boss bullet to be relative to direction of movement
		rotation_degrees = -direction.x * 90
		bullet_has_shot = true
		
func _on_Shoot_rd():
	if !bullet_has_shot:
		# Set direction equal to a normalized vector pointing left-down
		var direction = (Vector2(1,8)).normalized()
		linear_velocity = direction * BULLET_SPEED
		# Set rotation of boss bullet to be relative to direction of movement
		rotation_degrees = -direction.x * 90
		bullet_has_shot = true
		
func _on_Shoot_lds():
	if !bullet_has_shot:
		# Set direction equal to a normalized vector pointing left-down
		var direction = (Vector2(-1,4)).normalized()
		linear_velocity = direction * BULLET_SPEED
		# Set rotation of boss bullet to be relative to direction of movement
		rotation_degrees = -direction.x * 90
		bullet_has_shot = true
		
func _on_Shoot_rds():
	if !bullet_has_shot:
		# Set direction equal to a normalized vector pointing left-down
		var direction = (Vector2(1,4)).normalized()
		linear_velocity = direction * BULLET_SPEED
		# Set rotation of boss bullet to be relative to direction of movement
		rotation_degrees = -direction.x * 90
		bullet_has_shot = true
