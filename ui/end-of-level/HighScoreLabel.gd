extends Label

const LEVEL1_SAVE_FILE_PATH = "user://level1_highscore.save"
const LEVEL2_SAVE_FILE_PATH = "user://level2_highscore.save"
const LEVEL3_SAVE_FILE_PATH = "user://level3_highscore.save"

var current_highscore
var data_loaded = false

func _process(_delta):
	if Global.new_highscore:
		self.text = "New High Score: " + str(Global.score)
	elif !Global.highscore_loaded:
		var save_data = File.new()
		if Global.level == 1 and save_data.file_exists(LEVEL1_SAVE_FILE_PATH):
			save_data.open(LEVEL1_SAVE_FILE_PATH, File.READ)
			Global.highscore = save_data.get_var()
			save_data.close()
		elif Global.level == 2 and save_data.file_exists(LEVEL2_SAVE_FILE_PATH):
			save_data.open(LEVEL2_SAVE_FILE_PATH, File.READ)
			Global.highscore = save_data.get_var()
			save_data.close()
		elif Global.level == 3 and save_data.file_exists(LEVEL3_SAVE_FILE_PATH):
			save_data.open(LEVEL3_SAVE_FILE_PATH, File.READ)
			Global.highscore = save_data.get_var()
			save_data.close()
		self.text = "High Score: " + str(Global.highscore)
		Global.highscore_loaded = true
