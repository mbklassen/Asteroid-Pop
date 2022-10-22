extends Label


func _process(_delta):
	if !Global.new_highscore:
		self.text = "Your Score:\n" + str(Global.score)
	else: 
		self.text = "New High Score:\n" + str(Global.score)
