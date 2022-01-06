extends Label


# Writes the score (from the the Global script) to the label
func _process(_delta):
	self.text = "Level " + str(Global.level) + "   "
