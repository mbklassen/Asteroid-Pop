extends Label


# Writes the score (from the Global.gd script) to label
func _process(_delta):
	self.text = "    Score " + str(Global.score)
