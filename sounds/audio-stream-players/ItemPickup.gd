extends AudioStreamPlayer


func _ready():
	play()

func _on_ItemPickup_finished():
	queue_free()
