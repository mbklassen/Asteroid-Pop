extends AudioStreamPlayer


func _ready():
	play()

func _on_BossShootSuper_finished():
	queue_free()
