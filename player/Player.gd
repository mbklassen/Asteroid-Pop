extends KinematicBody2D

# Get width and height of viewport
onready var screen_width = get_viewport_rect().size.x
onready var screen_height = get_viewport_rect().size.y

func _ready():
	# Set player position to the lower center of the screen
	position = Vector2((screen_width/2), (screen_height - 100))
	
func _physics_process(_delta):
	# Get player velocity from move state node
	var player_velocity = $States/Move.velocity
	# Moves player according to velocity vector
	# Also handles collision (slides along walls)
	var _collision = move_and_slide(player_velocity)
