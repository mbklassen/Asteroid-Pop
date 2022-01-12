extends Node

const GAMEOVER_WAIT_TIME = 1
const PAUSE_WAIT_TIME = 0.1
const LEVEL_END_WAIT_TIME = 4
const LEVEL1_SAVE_FILE_PATH = "user://level1_highscore.save"
const LEVEL2_SAVE_FILE_PATH = "user://level2_highscore.save"
const LEVEL3_SAVE_FILE_PATH = "user://level3_highscore.save"
const LEVEL4_SAVE_FILE_PATH = "user://level4_highscore.save"

var gameover_timer
var pause_timer
var level_end_timer

func _ready():
	
	gameover_timer = $UI/GameOver/GameOverTimer
	gameover_timer.wait_time = GAMEOVER_WAIT_TIME
	# When gameover_timer times out, the function _on_gameover_timer_timeout() is run
	gameover_timer.connect("timeout", self, "_on_gameover_timer_timeout")
	
	pause_timer = $UI/Pause/PauseTimer
	pause_timer.wait_time = PAUSE_WAIT_TIME
	# When pause_timer times out, the function _on_pause_timer_timeout() is run
	pause_timer.connect("timeout", self, "_on_pause_timer_timeout")
	
	level_end_timer = $UI/EndOfLevel/LevelEndTimer
	level_end_timer.wait_time = LEVEL_END_WAIT_TIME
	# When level_end_timer times out, the function _on_level_end_timer_timeout() is run
	level_end_timer.connect("timeout", self, "_on_level_end_timer_timeout")

func _process(_delta):
	# If player dies or the score reaches zero on a boss level, and gameover_timer is stopped, then start gameover_timer
	if (Global.hp <= 0 or (Global.score == 0 and Global.boss_level)) and (gameover_timer.is_stopped()) and (level_end_timer.is_stopped()):
		gameover_timer.start()
	# If level has ended and level_end_timer is stopped, then start level_end_timer
	if Global.level_ended and level_end_timer.is_stopped():
		level_end_timer.start()
		
	if Global.in_main_menu:
		$UI/MainMenu.visible = true
		
func _input(event):
	# If the pause button/key is pressed and both pause_timer and level_end_timer are stopped, then start pause_timer
	# The level_end_timer check is to prevent the game from being paused when the level is about to end
	if event.is_action_pressed("ui_home") and pause_timer.is_stopped() and level_end_timer.is_stopped() and gameover_timer.is_stopped():
		pause_timer.start()

# On gameover_timer timeout, if level has not ended, "game over" menu becomes visible and the rest of the game is paused
func _on_gameover_timer_timeout():
	$UI/GameOver.visible = true
	get_tree().paused = true

# On pause_timer timeout, "pause" menu becomes visible and the rest of the game is paused
func _on_pause_timer_timeout():
	$UI/Pause.visible = true
	get_tree().paused = true

# On level_end_timer timeout
# If player is on a normal level, "end of level" menu becomes visible and the rest of the game is paused
# Else if player is on the final level (boss level), "you win" menu becomes visible and the rest of the game is paused
func _on_level_end_timer_timeout():
	if Global.score > Global.highscore:
		save_highscore()
		Global.new_highscore = true
	if !Global.final_level:
		$UI/EndOfLevel.visible = true
	else:
		$UI/YouWin.visible = true
	get_tree().paused = true
	
func save_highscore():
	var save_data = File.new()
	if Global.level == 1:
		save_data.open(LEVEL1_SAVE_FILE_PATH, File.WRITE)
	elif Global.level == 2:
		save_data.open(LEVEL2_SAVE_FILE_PATH, File.WRITE)
	elif Global.level == 3:
		save_data.open(LEVEL3_SAVE_FILE_PATH, File.WRITE)
	elif Global.level == 4:
		save_data.open(LEVEL4_SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(Global.score)
	save_data.close()
