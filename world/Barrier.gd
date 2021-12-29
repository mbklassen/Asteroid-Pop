extends CollisionShape2D


func _process(_delta):
	if Global.boss_level and disabled:
		disabled = false
	elif !Global.boss_level and !disabled:
		disabled = true
