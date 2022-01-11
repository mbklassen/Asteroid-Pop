extends Button


func _process(_delta):
	if disabled and Global.level1_complete:
		disabled = false
