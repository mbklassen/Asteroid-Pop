extends AudioStreamPlayer


func _ready():
	play()

func _on_Explosion2_finished():
	queue_free()
