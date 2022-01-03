extends Node2D


const BOSS_TIMER_WAIT_TIME = 1

var boss_scene = preload("res://bosses/boss1/Boss1.tscn")
var boss_hp_scene = preload("res://ui/hud/HUD.tscn")
var enemy1_scene = preload("res://enemies/enemy1/Enemy1.tscn")

var screen_width
var boss_wait_timer
# Length of time between each enemy1
var enemy1_timer

func _ready():
	# Set Global variables
	Global.level = 4
	Global.first_level = false
	Global.final_level = true
	Global.score = 200
	Global.hp = 100
	Global.level_ended = false
	Global.boss_level = true
	Global.boss1_hp = 300
	Global.boss1_hp_visible = true
	
	screen_width = get_viewport_rect().size.x
	
	boss_wait_timer = $Timers/BossWaitTimer
	boss_wait_timer.wait_time = BOSS_TIMER_WAIT_TIME
	boss_wait_timer.start()
	
	enemy1_timer = $Timers/Enemy1Timer
	#enemy1_timer.wait_time = 4
	#enemy1_timer.start()
	
func _on_BossWaitTimer_timeout():
	var boss = boss_scene.instance()
	boss.global_position = Vector2(screen_width/2, -30)
	add_child(boss)
	
func _on_ScoreDecrementTimer_timeout():
	pass # Replace with function body.

func _on_Enemy1Timer_timeout():
	var enemy1 = enemy1_scene.instance()
	enemy1.global_position = Vector2(rand_range(20, 340), -30)
	add_child(enemy1)
	enemy1_timer.wait_time = rand_range(1, 2.5)
	enemy1_timer.start()

