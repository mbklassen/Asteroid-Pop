extends KinematicBody2D


var screen_width
var screen_height

func _ready():
	# Get width and height of viewport
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	# Set player position to the lower center of the screen
	global_position = Vector2((screen_width/2), (screen_height - 60))
	
func _physics_process(_delta):
	
	Global.player_position = global_position
	
	if Global.item_health_acquired:
		if Global.hp > 80:
			Global.hp = 100
		else:
			Global.hp += 20
		Global.item_health_acquired = false
	if Global.hp <= 0:
		queue_free()
