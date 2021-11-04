extends KinematicBody2D


func _ready():
	position = Vector2((get_viewport_rect().size.x/2), (get_viewport_rect().size.y - 100))
	print("Player position: " + str(position))
	
func _physics_process(delta):	
	# Moves player according to velocity vector
	# Also handles collision
	var _collision = move_and_collide(get_node("States/Move").velocity * delta)
