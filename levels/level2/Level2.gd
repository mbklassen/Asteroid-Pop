extends Node2D

const LEVEL_TIMER_WAIT_TIME = 120
const LEVEL_END_TIMER_WAIT_TIME = 4

var asteroid_top_scene2 = load("res://asteroids/AsteroidTop.tscn")
var asteroid_left_scene2 = load("res://asteroids/AsteroidLeft.tscn")
var asteroid_right_scene2 = load("res://asteroids/AsteroidRight.tscn")

# Length of time for this level
var level2_timer
# Wait time at the end of this level
var level2_end_timer
# Length of time between each asteroid coming from the top
var asteroid_top_timer2
# Length of time between each asteroid coming from the right/left
var asteroid_rl_timer2


func _ready():
	Global.first_level = false
	Global.final_level = true
	Global.level = 2
	Global.score = 0
	Global.hp = 100
	# Get LevelTimer node and connect its timeout signal to _on_level_timer_timeout() method
	level2_timer = get_node("Timers/Level2Timer")
	level2_timer.wait_time = LEVEL_TIMER_WAIT_TIME
	level2_timer.start()
	# Get LevelEndTimer node and connect its timeout signal to _on_level_end_timer_timeout() method
	level2_end_timer = get_node("Timers/Level2EndTimer")
	level2_end_timer.wait_time = LEVEL_END_TIMER_WAIT_TIME
	# Get AsteroidTopTimer node
	asteroid_top_timer2 = get_node("Timers/AsteroidTopTimer2")
	_setup_asteroid_top_timer()
	# Get AsteroidRLTimer node
	asteroid_rl_timer2 = get_node("Timers/AsteroidRLTimer2")
	_setup_asteroid_rl_timer()
	
func _setup_asteroid_top_timer():
	asteroid_top_timer2.wait_time = rand_range(0.1, 2)
	asteroid_top_timer2.start()

func _setup_asteroid_rl_timer():
	asteroid_rl_timer2.wait_time = rand_range(0.1, 2)
	asteroid_rl_timer2.start()
	
func _on_Level2Timer_timeout():
	asteroid_top_timer2.stop()
	asteroid_rl_timer2.stop()
	level2_end_timer.start()

func _on_Level2EndTimer_timeout():
	pass

func _on_AsteroidTopTimer2_timeout():
	var asteroid_top = asteroid_top_scene2.instance()
	asteroid_top.position = Vector2(rand_range(20, 340), -30)
	add_child(asteroid_top)
	_setup_asteroid_top_timer()


func _on_AsteroidRLTimer2_timeout():
	var asteroid_rl_spawn_side = rand_range(0, 2)
	# Spawn from the left, travelling right
	if asteroid_rl_spawn_side < 1:
		var asteroid_left = asteroid_left_scene2.instance()
		asteroid_left.position = Vector2(-30, rand_range(-30, 350))
		add_child(asteroid_left)
		
	# Spawn from the right, travelling left
	elif asteroid_rl_spawn_side >= 1:
		var asteroid_right = asteroid_right_scene2.instance()
		asteroid_right.position = Vector2(390, rand_range(-30, 350))
		add_child(asteroid_right)

	_setup_asteroid_rl_timer()
