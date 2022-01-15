extends AudioStreamPlayer


func _ready():
	play()

func _on_BossShoot_finished():
	queue_free()
