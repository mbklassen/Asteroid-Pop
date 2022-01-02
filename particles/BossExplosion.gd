extends Particles2D


# Queue explosion to be freed when it is done emitting
func _process(_delta):
	if !emitting:
		queue_free()
