extends Label


func _process(_delta):
	if Global.new_highscore:
		self.text = str(Global.score)
		visible = true
