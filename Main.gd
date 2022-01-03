extends Node

const GAMEOVER_WAIT_TIME = 0.1
const PAUSE_WAIT_TIME = 0.1
const LEVEL_END_WAIT_TIME = 4

var gameover_timer
var pause_timer
var level_end_timer

func _ready():
	gameover_timer = $UI/GameOver/GameOverTimer
	gameover_timer.wait_time = GAMEOVER_WAIT_TIME
	gameover_timer.connect("timeout", self, "_on_gameover_timer_timeout")
	
	pause_timer = $UI/Pause/PauseTimer
	pause_timer.wait_time = PAUSE_WAIT_TIME
	pause_timer.connect("timeout", self, "_on_pause_timer_timeout")
	
	level_end_timer = $UI/EndOfLevel/LevelEndTimer
	level_end_timer.wait_time = LEVEL_END_WAIT_TIME
	level_end_timer.connect("timeout", self, "_on_level_end_timer_timeout")

func _process(_delta):
	if (Global.hp <= 0 or (Global.score == 0 and Global.boss_level)) and (gameover_timer.is_stopped()):
		gameover_timer.start()
	if Global.level_ended and level_end_timer.is_stopped():
		level_end_timer.start()
		
func _input(event):
	if event.is_action_pressed("ui_home") and pause_timer.is_stopped():
		pause_timer.start()

func _on_gameover_timer_timeout():
	$UI/GameOver.visible = true
	get_tree().paused = true

func _on_pause_timer_timeout():
	$UI/Pause.visible = true
	get_tree().paused = true

func _on_level_end_timer_timeout():
	if !Global.final_level:
		$UI/EndOfLevel.visible = true
	else:
		$UI/YouWin.visible = true
	get_tree().paused = true
