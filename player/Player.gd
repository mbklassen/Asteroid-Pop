extends KinematicBody2D


onready var screen_width = get_viewport_rect().size.x
onready var screen_height = get_viewport_rect().size.y

func _ready():
	position = Vector2((screen_width/2), (screen_height - 100))
	
func _physics_process(_delta):	
	# Moves player according to velocity vector
	# Also handles collision
	var player_velocity = get_node("States/Move").velocity
	var _collision = move_and_slide(player_velocity)
