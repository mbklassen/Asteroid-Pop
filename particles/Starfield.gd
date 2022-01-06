extends Particles2D

# Turn on downward moving starfield when not on boss level, turn off otherwise
func _physics_process(_delta):
	if !Global.boss_level and !emitting:
		emitting = true
		visible = true
	elif Global.boss_level and emitting:
		emitting = false
		visible = false
