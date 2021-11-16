extends Control


var focus_grabbed = false
var in_pause_menu = false

func _process(_delta):
	if visible and !in_pause_menu:
		in_pause_menu = true
	if get_tree().paused and !focus_grabbed and in_pause_menu:
		$VBoxContainer/ContinueButton.grab_focus()
		focus_grabbed = true

func _on_ContinueButton_pressed():
	if get_tree().paused:
		visible = false
		get_tree().paused = false
		focus_grabbed = false
		in_pause_menu = false

func _on_RestartButton_pressed():
	if get_tree().paused:
		var _restart = get_tree().reload_current_scene()
		get_tree().paused = false
		focus_grabbed = false
		in_pause_menu = false

func _on_QuitButton_pressed():
	if get_tree().paused:
		get_tree().quit()
