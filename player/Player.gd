extends KinematicBody2D

# get width and height of viewport
onready var screen_width = get_viewport_rect().size.x
onready var screen_height = get_viewport_rect().size.y

func _ready():
	# set player position to the lower center of the screen
	position = Vector2((screen_width/2), (screen_height - 100))
	
func _physics_process(_delta):
	# get player velocity from move state node
	var player_velocity = get_node("States/Move").velocity
	# moves player according to velocity vector
	# also handles collision (slides along walls)
	var _collision = move_and_slide(player_velocity)
