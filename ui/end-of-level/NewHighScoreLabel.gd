extends Label


func _process(_delta):
	if Global.new_highscore:
		self.text = "New high score: " + str(Global.score)
		visible = true
