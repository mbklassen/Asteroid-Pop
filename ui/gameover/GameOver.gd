extends Control


var focus_grabbed = false

func _process(_delta):
	if get_tree().paused and !focus_grabbed and !Global.game_paused:
		$VBoxContainer/RestartButton.grab_focus()
		focus_grabbed = true

func _on_RestartButton_pressed():
	if get_tree().paused and !Global.game_paused:
		var _restart = get_tree().reload_current_scene()
		get_tree().paused = false

func _on_QuitButton_pressed():
	if get_tree().paused and !Global.game_paused:
		get_tree().quit()

