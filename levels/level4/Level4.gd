extends Node2D

# Length of time before boss spawns above top of screen
const BOSS_TIMER_WAIT_TIME = 1
# Time between each score decrement
const SCORE_DECREMENT_WAIT_TIME = 0.6
# Threshold of boss hp at which regular enemies start spawning
const ENEMY1_SPAWNING_HP = 150
const SAVE_FILE_PATH = "user://level4_highscore.save"

var boss_scene = preload("res://bosses/boss1/Boss1.tscn")
var boss_hp_scene = preload("res://ui/hud/HUD.tscn")
var enemy1_scene = preload("res://enemies/enemy1/Enemy1.tscn")

var screen_width
var boss_wait_timer
# Length of time between each enemy1
var enemy1_timer
var score_decrement_timer

func _ready():
	# Set Global variables
	Global.level = 4
	Global.first_level = false
	Global.final_level = true
	Global.score = 200
	Global.hp = 100
	Global.level_ended = false
	Global.new_highscore = false
	Global.highscore = 0
	
	Global.boss_level = true
	Global.boss1_hp = 300
	Global.boss1_hp_visible = true
	Global.boss1_super_mode = false
	Global.boss_dead = false
	
	load_highscore()
	
	# Get screen width for boss initial position
	screen_width = get_viewport_rect().size.x
	
	# Initialize and start timer for boss to spawn
	boss_wait_timer = $Timers/BossWaitTimer
	boss_wait_timer.wait_time = BOSS_TIMER_WAIT_TIME
	boss_wait_timer.start()
	
	# Initialize and start timer for decrementing the score 
	score_decrement_timer = $Timers/ScoreDecrementTimer
	score_decrement_timer.wait_time = SCORE_DECREMENT_WAIT_TIME
	score_decrement_timer.start()
	
	# Initialize (but don't start) timer for spawning regular enemies (enemy1)
	enemy1_timer = $Timers/Enemy1Timer
	enemy1_timer.wait_time = 0.1

func _physics_process(_delta):
	# If boss reaches half hp and enemy1_timer is stopped, then start enemy1_timer for spawning regular enemies
	# Global.level_ended check is to ensure no more enemies spawn once boss is destoryed (since enemy1_timer is stopped at this point)
	if Global.boss1_hp <= ENEMY1_SPAWNING_HP and enemy1_timer.is_stopped() and !Global.level_ended:
		enemy1_timer.start()
	
	# If boss hp reaches zero and level isn't ending, then delete boss node, stop enemy1_timer, and end the level
	# (When Global.level_ended is set to true, a timer is started by Main.gd to show "you win" menu)
	if Global.boss_dead and !Global.level_ended:
		for child in get_children():
			if child.is_in_group("bosses"):
				child.queue_free()
		enemy1_timer.stop()
		score_decrement_timer.stop()
		Global.level_ended = true

func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		Global.highscore = save_data.get_var()
		save_data.close()

func _on_BossWaitTimer_timeout():
	var boss = boss_scene.instance()
	boss.global_position = Vector2(screen_width/2, -30)
	add_child(boss)
	
func _on_ScoreDecrementTimer_timeout():
	Global.score -= 1
	score_decrement_timer.wait_time = SCORE_DECREMENT_WAIT_TIME
	score_decrement_timer.start()

func _on_Enemy1Timer_timeout():
	var enemy1 = enemy1_scene.instance()
	enemy1.global_position = Vector2(rand_range(20, 340), -30)
	add_child(enemy1)
	enemy1_timer.wait_time = rand_range(1.5, 2.5)
	enemy1_timer.start()

