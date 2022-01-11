extends Control


var focus_grabbed = false
var in_level_end_menu = false

func _process(_delta):
	# If menu is visible then we are now in the menu
	if visible and !in_level_end_menu:
		in_level_end_menu = true
	# If game is paused and a menu button is not selected and we are in the menu
	# then grab focus (select) the "next level" button
	# Focus is now grabbed (a menu button is selected)
	if get_tree().paused and !focus_grabbed and in_level_end_menu:
		$VBoxContainer/NextLevelButton.grab_focus()
		focus_grabbed = true

# When "next level" button is pressed, hide the menu and move to next level
# (Incrementing Global.level causes the World node to change the level)
func _on_NextLevelButton_pressed():
	if get_tree().paused:
		get_tree().paused = false
		focus_grabbed = false
		in_level_end_menu = false
		visible = false
		Global.level += 1
		Global.level_ended = false
		
func _on_MainMenuButton_pressed():
	if get_tree().paused:
		var _restart = get_tree().reload_current_scene()
		visible = false
		in_level_end_menu = false
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
		in_level_end_menu = false
