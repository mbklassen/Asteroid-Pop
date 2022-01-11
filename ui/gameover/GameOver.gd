extends Control


var focus_grabbed = false
var in_game_over_menu = false

func _process(_delta):
	# If menu is visible then we are now in the menu
	if visible and !in_game_over_menu:
		in_game_over_menu = true
	# If game is paused and a menu button is not selected and we are in the menu
	# then grab focus (select) the "restart" button
	# Focus is now grabbed (a menu button is selected)
	if get_tree().paused and !focus_grabbed and in_game_over_menu:
		$VBoxContainer/RestartButton.grab_focus()
		focus_grabbed = true

# When "restart" button is pressed, hide the menu and restart current level
func _on_RestartButton_pressed():
	if get_tree().paused:
		var _restart = get_tree().reload_current_scene()
		get_tree().paused = false
		focus_grabbed = false
		in_game_over_menu = false

func _on_MainMenuButton_pressed():
	if get_tree().paused:
		var _restart = get_tree().reload_current_scene()
		visible = false
		in_game_over_menu = false
		focus_grabbed = false
		get_tree().paused = false
		Global.in_main_menu = true
