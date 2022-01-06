extends ProgressBar


func _process(_delta):
	# Visibility and value determined by variables in the Global script
	visible = Global.boss1_hp_visible
	value = Global.boss1_hp
