extends Node

const GAMEOVER_WAIT_TIME = 0.1
var gameover_timer

func _ready():
	gameover_timer = $UI/GameOver/GameOverTimer
	gameover_timer.wait_time = GAMEOVER_WAIT_TIME
	gameover_timer.connect("timeout", self, "_on_gameover_timer_timeout")

func _process(_delta):
	if Global.hp <= 0 and gameover_timer.is_stopped():
		gameover_timer.start()

func _on_gameover_timer_timeout():
	$UI/GameOver.visible = true
	get_tree().paused = true
