extends Node2D


const LEVEL_TIMER_WAIT_TIME = 60
const LEVEL_END_TIMER_WAIT_TIME = 4

var asteroid_top_scene = preload("res://asteroids/AsteroidTop.tscn")
var asteroid_left_scene = preload("res://asteroids/AsteroidLeft.tscn")
var asteroid_right_scene = preload("res://asteroids/AsteroidRight.tscn")

# Length of time for this level
var level2_timer
# Length of time between each asteroid coming from the top
var asteroid_top_timer
# Length of time between each asteroid coming from the right/left
var asteroid_rl_timer


func _ready():
	# Set Global variables
	Global.level = 2
	Global.first_level = false
	Global.final_level = false
	Global.score = 0
	Global.hp = 100
	Global.level_ended = false
	Global.boss_level = false
	Global.boss1_hp_visible = false
	
	level2_timer = $Timers/Level2Timer
	level2_timer.wait_time = LEVEL_TIMER_WAIT_TIME
	level2_timer.start()
	
	asteroid_top_timer = $Timers/AsteroidTopTimer
	_setup_asteroid_top_timer()
	
	asteroid_rl_timer = $Timers/AsteroidRLTimer
	_setup_asteroid_rl_timer()
	
	
func _setup_asteroid_top_timer():
	asteroid_top_timer.wait_time = rand_range(0.1, 2)
	asteroid_top_timer.start()

func _setup_asteroid_rl_timer():
	asteroid_rl_timer.wait_time = rand_range(0.1, 2)
	asteroid_rl_timer.start()
	
func _on_Level2Timer_timeout():
	asteroid_top_timer.stop()
	asteroid_rl_timer.stop()
	Global.level_ended = true

func _on_AsteroidTopTimer_timeout():
	var asteroid_top = asteroid_top_scene.instance()
	asteroid_top.global_position = Vector2(rand_range(20, 340), -30)
	add_child(asteroid_top)
	_setup_asteroid_top_timer()

func _on_AsteroidRLTimer_timeout():
	var asteroid_rl_spawn_side = rand_range(0, 2)
	# Spawn from the left, travelling right
	if asteroid_rl_spawn_side < 1:
		var asteroid_left = asteroid_left_scene.instance()
		asteroid_left.global_position = Vector2(-30, rand_range(-30, 350))
		add_child(asteroid_left)
		
	# Spawn from the right, travelling left
	elif asteroid_rl_spawn_side >= 1:
		var asteroid_right = asteroid_right_scene.instance()
		asteroid_right.global_position = Vector2(390, rand_range(-30, 350))
		add_child(asteroid_right)

	_setup_asteroid_rl_timer()
