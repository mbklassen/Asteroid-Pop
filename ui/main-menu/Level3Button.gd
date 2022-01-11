extends Button


func _process(_delta):
	if disabled and Global.level2_complete:
		disabled = false
