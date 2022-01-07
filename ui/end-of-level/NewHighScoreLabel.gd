extends Label


func _process(_delta):
	if Global.new_highscore:
		visible = true
