extends Label


func _process(_delta):
	if Global.new_highscore:
		self.text = "New High Score: " + str(Global.score)
		visible = true
