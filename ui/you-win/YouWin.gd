extends Control


var focus_grabbed = false
var in_you_win_menu = false

func _process(_delta):
	# If menu is visible then we are now in the menu
	if visible and !in_you_win_menu:
		in_you_win_menu = true
	# If game is paused and a menu button is not selected and we are in the menu
	# then grab focus (select) the "restart" button
	# Focus is now grabbed (a menu button is selected)
	if get_tree().paused and !focus_grabbed and in_you_win_menu:
		$VBoxContainer/MainMenuButton.grab_focus()
		focus_grabbed = true

func _on_MainMenuButton_pressed():
	if get_tree().paused:
		var _restart = get_tree().reload_current_scene()
		visible = false
		in_you_win_menu = false
		focus_grabbed = false
		get_tree().paused = false
		Global.level_ended = false
		Global.in_main_menu = true

# When "restart" button is pressed, hide the menu and restart current level
func _on_RestartButton_pressed():
	if get_tree().paused:
		var _restart = get_tree().reload_current_scene()
		get_tree().paused = false
		focus_grabbed = false
		in_you_win_menu = false
