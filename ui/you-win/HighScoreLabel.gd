extends Label

const LEVEL4_SAVE_FILE_PATH = "user://level4_highscore.save"

var current_highscore
var data_loaded = false

func _process(_delta):
	if Global.new_highscore:
		self.text = "New High Score: " + str(Global.score)
	elif !Global.highscore_loaded:
		var save_data = File.new()
		if Global.level == 4 and save_data.file_exists(LEVEL4_SAVE_FILE_PATH):
			save_data.open(LEVEL4_SAVE_FILE_PATH, File.READ)
			Global.highscore = save_data.get_var()
			save_data.close()
		self.text = "High Score: " + str(Global.highscore)
		Global.highscore_loaded = true
