extends AudioStreamPlayer

func _ready():
	play()

func _on_AsteroidPop_finished():
	queue_free()
