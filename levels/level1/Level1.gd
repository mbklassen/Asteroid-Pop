extends Node2D

const LEVEL_TIMER_WAIT_TIME = 25
const LEVEL_END_TIMER_WAIT_TIME = 4

var asteroid_scene = load("res://asteroids/AsteroidTop.tscn")

# length of time for this level
var level_timer
# wait time at the end of this level
var level_end_timer
# length of time between each asteroid
var asteroid_timer


func _ready():
	# get LevelTimer node and connect its timeout signal to _on_level_timer_timeout() method
	level_timer = get_node("Timers/LevelTimer")
	level_timer.wait_time = LEVEL_TIMER_WAIT_TIME
	level_timer.start()
	# get LevelEndTimer node and connect its timeout signal to _on_level_end_timer_timeout() method
	level_end_timer = get_node("Timers/LevelEndTimer")
	level_end_timer.wait_time = LEVEL_END_TIMER_WAIT_TIME
	# get AsteroidTimer node
	asteroid_timer = get_node("Timers/AsteroidTimer")
	_setup_asteroid_timer()
	
	
func _setup_asteroid_timer():
	asteroid_timer.wait_time = rand_range(0.1, 2)
	asteroid_timer.start()
	
func _on_LevelTimer_timeout():
	asteroid_timer.stop()
	level_end_timer.start()

func _on_LevelEndTimer_timeout():
	Global.score = 0
	Global.level += 1

func _on_AsteroidTimer_timeout():
	var asteroid = asteroid_scene.instance()
	asteroid.global_position = Vector2(rand_range(20, 340), -30)
	get_tree().current_scene.get_node("World").add_child(asteroid)
	asteroid_timer.start()
	print("Asteroid spawned")
