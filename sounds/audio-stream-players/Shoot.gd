extends AudioStreamPlayer

func _ready():
	play()

func _on_Shoot_finished():
	queue_free()
