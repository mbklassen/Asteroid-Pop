extends Button


func _process(_delta):
	if disabled and Global.level3_complete:
		disabled = false
