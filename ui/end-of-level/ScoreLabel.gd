extends Label


func _process(_delta):
	if !Global.new_highscore:
		self.text = "Your Score\n" + str(Global.score)
		visible = true
	else: 
		visible = false
 
