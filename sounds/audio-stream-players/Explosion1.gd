extends AudioStreamPlayer


func _ready():
	play()

func _on_Explosion1_finished():
	queue_free()
