extends Node

const ACCELERATION = 1300
const MAX_SPEED = 400
const FRICTION = 700

var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	# Get input_vector based on the which movement buttons are being pressed or which way the joystick is tilted
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	# Normalize input vector in order to calculate velocity
	input_vector = input_vector.normalized()
	
	# If movement button is being pressed, move velocity toward max speed
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	# Else if no movement button is pressed, move velocity toward zero
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# Moves player according to velocity vector
	# Also handles collision
	var _collision = get_parent().get_parent().move_and_slide(velocity)
