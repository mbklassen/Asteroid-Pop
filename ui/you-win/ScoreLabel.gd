extends Label


func _process(_delta):
	if !Global.new_highscore:
		self.text = "Current Score: " + str(Global.score)
		visible = true
	else: 
		visible = false
