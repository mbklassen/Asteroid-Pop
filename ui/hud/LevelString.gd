extends Label


# Writes the score (from the the Global script) to the label
func _process(_delta):
	self.text = "Level " + str(Global.level) + "   "
	# Visible on any level but boss level
	if Global.boss_level:
		visible = false
	else:
		visible = true
