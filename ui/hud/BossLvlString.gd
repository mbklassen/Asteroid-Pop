extends Label


# Writes the score (from the the Global script) to the label
func _process(_delta):
	self.text = "Level " + str(Global.level) + "   "
	# Visible on boss level only
	if Global.boss_level:
		visible = true
	else:
		visible = false
