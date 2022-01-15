extends AudioStreamPlayer


func _ready():
	play()

func _on_AsteroidPiecePop_finished():
	queue_free()
