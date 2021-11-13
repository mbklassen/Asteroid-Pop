extends Node2D

const LEVEL_TIMER_WAIT_TIME = 60
const LEVEL_END_TIMER_WAIT_TIME = 4

var asteroid_top_scene1 = preload("res://asteroids/AsteroidTop.tscn")

# Length of time for this level
var level1_timer
# Wait time at the end of this level
var level1_end_timer
# Length of time between each asteroid
var asteroid_top_timer1


func _ready():
	Global.first_level = true
	Global.final_level = false
	Global.level = 1
	Global.score = 0
	Global.hp = 100
	# Get LevelTimer node and connect its timeout signal to _on_level_timer_timeout() method
	level1_timer = get_node("Timers/Level1Timer")
	level1_timer.wait_time = LEVEL_TIMER_WAIT_TIME
	level1_timer.start()
	# Get LevelEndTimer node and connect its timeout signal to _on_level_end_timer_timeout() method
	level1_end_timer = get_node("Timers/Level1EndTimer")
	level1_end_timer.wait_time = LEVEL_END_TIMER_WAIT_TIME
	# Get AsteroidTimer node
	asteroid_top_timer1 = get_node("Timers/AsteroidTopTimer1")
	_setup_AsteroidTop_timer()
	
	
func _setup_AsteroidTop_timer():
	asteroid_top_timer1.wait_time = rand_range(0.1, 2)
	asteroid_top_timer1.start()


func _on_Level1Timer_timeout():
	asteroid_top_timer1.stop()
	level1_end_timer.start()


func _on_Level1EndTimer_timeout():
	pass

func _on_AsteroidTopTimer1_timeout():
	var asteroid_top = asteroid_top_scene1.instance()
	asteroid_top.position = Vector2(rand_range(20, 340), -30)
	add_child(asteroid_top)
	_setup_AsteroidTop_timer()
