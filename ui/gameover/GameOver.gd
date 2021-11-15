extends Control


var focus_grabbed = false
var in_game_over_menu = false

func _process(_delta):
	if visible and !in_game_over_menu:
		in_game_over_menu = true
	if get_tree().paused and !focus_grabbed and in_game_over_menu:
		$VBoxContainer/RestartButton.grab_focus()
		focus_grabbed = true

func _on_RestartButton_pressed():
	if get_tree().paused:
		var _restart = get_tree().reload_current_scene()
		get_tree().paused = false
		focus_grabbed = false
		in_game_over_menu = false

func _on_QuitButton_pressed():
	if get_tree().paused:
		get_tree().quit()

