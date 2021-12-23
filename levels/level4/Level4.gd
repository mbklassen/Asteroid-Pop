extends Node2D


const BOSS_TIMER_WAIT_TIME = 1

var boss_scene = preload("res://bosses/boss1/Boss1.tscn")

var screen_width
var boss_wait_timer

func _ready():
	# Set Global variables
	Global.level = 4
	Global.first_level = false
	Global.final_level = true
	Global.score = 200
	Global.hp = 100
	Global.level_ended = false
	
	screen_width = get_viewport_rect().size.x
	
	boss_wait_timer = $Timers/BossWaitTimer
	boss_wait_timer.wait_time = BOSS_TIMER_WAIT_TIME
	boss_wait_timer.start()
	
func _on_BossStartTimer_timeout():
	var boss = boss_scene.instance()
	boss.global_position = Vector2(screen_width/2, -30)
	add_child(boss)

func _on_ScoreDecrementTimer_timeout():
	pass # Replace with function body.
