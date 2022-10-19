extends Label


# Writes the score (from the Global script) to label
func _process(_delta):
	self.text = "    Score " + str(Global.score)
	# Visible only on boss level
	if Global.boss_level:
		visible = true
	else:
		visible = false
