extends Node2D

const LEVEL_TIMER_WAIT_TIME = 15
const LEVEL_END_TIMER_WAIT_TIME = 4
const SAVE_FILE_PATH = "user://level1_highscore.save"

var asteroid_top_scene1 = preload("res://asteroids/AsteroidTop.tscn")

# Length of time for this level
var level1_timer
# Length of time between each asteroid
var asteroid_top_timer


func _ready():
	# Set Global variables
	Global.level = 1
	Global.first_level = true
	Global.final_level = false
	Global.score = 0
	Global.hp = 100
	Global.level_ended = false
	Global.new_highscore = false
	
	Global.boss_level = false
	Global.boss1_hp_visible = false
	
	load_highscore()
	
	# Get LevelTimer node and connect its timeout signal to _on_level_timer_timeout() method
	level1_timer = $Timers/Level1Timer
	level1_timer.wait_time = LEVEL_TIMER_WAIT_TIME
	level1_timer.start()
	# Get AsteroidTimer node
	asteroid_top_timer = $Timers/AsteroidTopTimer
	_setup_AsteroidTop_timer()
	
func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		Global.highscore = save_data.get_var()
		save_data.close()
		print("loaded variable from file: " + str(Global.highscore))

func _setup_AsteroidTop_timer():
	asteroid_top_timer.wait_time = rand_range(0.1, 2)
	asteroid_top_timer.start()

# (When Global.level_ended is set to true, a timer is started by Main.gd to show "end of level" menu)
func _on_Level1Timer_timeout():
	asteroid_top_timer.stop()
	Global.level_ended = true

func _on_AsteroidTopTimer_timeout():
	var asteroid_top = asteroid_top_scene1.instance()
	asteroid_top.global_position = Vector2(rand_range(20, 340), -30)
	add_child(asteroid_top)
	_setup_AsteroidTop_timer()
