extends Particles2D

# Turn on downward moving starfield when not on boss level, turn off otherwise
func _physics_process(_delta):
	if !emitting:
		emitting = true
		visible = true
