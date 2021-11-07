extends Node2D

const LEVEL_TIMER_WAIT_TIME = 30
const LEVEL_END_TIMER_WAIT_TIME = 4

var asteroid_top_scene = preload("res://asteroids/AsteroidTop.tscn")
var asteroid_left_scene = preload("res://asteroids/AsteroidLeft.tscn")
var asteroid_right_scene = preload("res://asteroids/AsteroidRight.tscn")

var world_node
# Length of time for this level
var level_timer
# Wait time at the end of this level
var level_end_timer
# Length of time between each asteroid coming from the top
var asteroid_top_timer
# Length of time between each asteroid coming from the right/left
var asteroid_rl_timer


func _ready():
	world_node = get_tree().current_scene.get_node("World")
	# Get LevelTimer node and connect its timeout signal to _on_level_timer_timeout() method
	level_timer = $Timers/LevelTimer
	level_timer.wait_time = LEVEL_TIMER_WAIT_TIME
	level_timer.start()
	# Get LevelEndTimer node and connect its timeout signal to _on_level_end_timer_timeout() method
	level_end_timer = $Timers/LevelEndTimer
	level_end_timer.wait_time = LEVEL_END_TIMER_WAIT_TIME
	# Get AsteroidTopTimer node
	asteroid_top_timer = $Timers/AsteroidTopTimer
	_setup_asteroid_top_timer()
	# Get AsteroidRLTimer node
	asteroid_rl_timer = $Timers/AsteroidRLTimer
	_setup_asteroid_rl_timer()
	
func _setup_asteroid_top_timer():
	asteroid_top_timer.wait_time = rand_range(0.1, 2)
	asteroid_top_timer.start()

func _setup_asteroid_rl_timer():
	asteroid_rl_timer.wait_time = rand_range(0.1, 2)
	asteroid_rl_timer.start()
	
func _on_LevelTimer_timeout():
	asteroid_top_timer.stop()
	asteroid_rl_timer.stop()
	level_end_timer.start()

func _on_LevelEndTimer_timeout():
	Global.score = 0
	Global.level += 1

func _on_AsteroidTopTimer_timeout():
	var asteroid_top = asteroid_top_scene.instance()
	asteroid_top.global_position = Vector2(rand_range(20, 340), -30)
	world_node.add_child(asteroid_top)
	asteroid_top_timer.start()


func _on_AsteroidRLTimer_timeout():
	var asteroid_rl_spawn_side = rand_range(0, 2)
	# Spawn from the left, travelling right
	if asteroid_rl_spawn_side < 1:
		var asteroid_left = asteroid_left_scene.instance()
		asteroid_left.global_position = Vector2(-30, rand_range(-30, 350))
		world_node.add_child(asteroid_left)
		
	# Spawn from the right, travelling left
	elif asteroid_rl_spawn_side >= 1:
		var asteroid_right = asteroid_right_scene.instance()
		asteroid_right.global_position = Vector2(390, rand_range(-30, 350))
		world_node.add_child(asteroid_right)

	asteroid_rl_timer.start()
