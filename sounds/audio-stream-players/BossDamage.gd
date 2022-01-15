extends AudioStreamPlayer


func _ready():
	play()

func _on_BossDamage_finished():
	queue_free()
