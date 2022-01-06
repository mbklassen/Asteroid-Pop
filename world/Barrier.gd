extends CollisionShape2D


func _process(_delta):
	# If on a boss level, enable an invisible wall between player and boss
	# Prevents unwanted interactions
	if Global.boss_level and disabled:
		disabled = false
	elif !Global.boss_level and !disabled:
		disabled = true
