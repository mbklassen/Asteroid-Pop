extends AudioStreamPlayer

func _ready():
	play()

func _on_Enemy1Shoot_finished():
	queue_free()

