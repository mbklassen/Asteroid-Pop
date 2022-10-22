extends Particles2D

func _ready():
	preprocess = 80
	lifetime = 200
	process_material.initial_velocity = 5
	amount = 10
	emitting = true
