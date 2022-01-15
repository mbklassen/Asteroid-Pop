extends KinematicBody2D


var death_explosion_scene = preload("res://explosions/ExplosionBig.tscn")

var explosion_sound_scene = preload("res://sounds/audio-stream-players/Explosion2.tscn")

var screen_width
var screen_height
var level_node

func _ready():
	# Get width and height of viewport
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	# Set player position to the lower center of the screen
	global_position = Vector2((screen_width/2), (screen_height - 60))
	
	level_node = get_parent()
	
func _physics_process(_delta):
	
	Global.player_position = global_position
	
	if Global.item_health_acquired:
		if Global.hp > 80:
			Global.hp = 100
		else:
			Global.hp += 20
		Global.item_health_acquired = false
	if Global.hp <= 0:
		var explosion_sound = explosion_sound_scene.instance()
		level_node.add_child(explosion_sound)
		
		var death_explosion = death_explosion_scene.instance()
		death_explosion.global_position = global_position
		level_node.add_child(death_explosion)
		queue_free()
