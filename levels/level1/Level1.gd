extends Node2D

const LEVEL_TIMER_WAIT_TIME = 30
const LEVEL_END_TIMER_WAIT_TIME = 4

var asteroid_top_scene = load("res://asteroids/AsteroidTop.tscn")

var world_node
# Length of time for this level
var level_timer
# Wait time at the end of this level
var level_end_timer
# Length of time between each asteroid
var asteroid_top_timer


func _ready():
	Global.first_level = true
	Global.final_level = false
	Global.level = 1
	Global.score = 0
	Global.hp = 100
	# Get LevelTimer node and connect its timeout signal to _on_level_timer_timeout() method
	level_timer = $Timers/LevelTimer
	level_timer.wait_time = LEVEL_TIMER_WAIT_TIME
	level_timer.start()
	# Get LevelEndTimer node and connect its timeout signal to _on_level_end_timer_timeout() method
	level_end_timer = $Timers/LevelEndTimer
	level_end_timer.wait_time = LEVEL_END_TIMER_WAIT_TIME
	# Get AsteroidTimer node
	asteroid_top_timer = $Timers/AsteroidTopTimer
	_setup_AsteroidTop_timer()
	
	
func _setup_AsteroidTop_timer():
	asteroid_top_timer.wait_time = rand_range(0.1, 2)
	asteroid_top_timer.start()
	
func _on_LevelTimer_timeout():
	asteroid_top_timer.stop()
	level_end_timer.start()

func _on_LevelEndTimer_timeout():
	pass

func _on_AsteroidTopTimer_timeout():
	var asteroid_top = asteroid_top_scene.instance()
	asteroid_top.global_position = Vector2(rand_range(20, 340), -30)
	add_child(asteroid_top)
	asteroid_top_timer.start()
