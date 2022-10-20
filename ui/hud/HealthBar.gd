extends ProgressBar


func _process(_delta):
	# Value determined by hp variable found in the Global script
	value = Global.hp
	
	# Once health is less than 100%, stop rounding the top right corner of the inner health bar
	var foreground = theme.get_stylebox("fg", "ProgressBar")
	if value < 100:
		foreground.corner_radius_top_right = 0
	else:
		foreground.corner_radius_top_right = 60
		
