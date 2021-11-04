extends Node

const ACCELERATION = 1300
const MAX_SPEED = 400
const FRICTION = 700

export var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	# Get input_vector based on the which movement buttons are being pressed or which way the joystick is tilted
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	# If movement button is being pressed, move velocity toward max speed
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	# Else if no movement button is pressed, move velocity toward zero
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
