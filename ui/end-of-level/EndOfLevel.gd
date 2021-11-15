extends Control


var focus_grabbed = false
var in_level_end_menu = false

func _process(_delta):
	if visible and !in_level_end_menu:
		in_level_end_menu = true
	if get_tree().paused and !focus_grabbed and in_level_end_menu:
		$VBoxContainer/NextLevelButton.grab_focus()
		focus_grabbed = true

func _on_NextLevelButton_pressed():
	if get_tree().paused:
		get_tree().paused = false
		focus_grabbed = false
		in_level_end_menu = false
		visible = false
		Global.level += 1
		Global.level_ended = false

func _on_RestartButton_pressed():
	if get_tree().paused:
		var _restart = get_tree().reload_current_scene()
		get_tree().paused = false
		focus_grabbed = false
		in_level_end_menu = false

func _on_QuitButton_pressed():
	if get_tree().paused:
		get_tree().quit()
