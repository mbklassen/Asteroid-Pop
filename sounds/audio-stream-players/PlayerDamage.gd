extends AudioStreamPlayer


func _ready():
	play()

func _on_PlayerDamage_finished():
	queue_free()
