extends ProgressBar


func _process(_delta):
	visible = Global.boss1_hp_visible
	value = Global.boss1_hp
