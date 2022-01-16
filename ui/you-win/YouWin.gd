extends Control

var change_focus_sound = preload("res://sounds/audio-stream-players/UIChange.tscn")
var select_sound_scene = preload("res://sounds/audio-stream-players/UISelect.tscn")

var focus_grabbed = false
var in_you_win_menu = false

func _process(_delta):
	# If menu is visible then we are now in the menu
	if visible and !in_you_win_menu:
		in_you_win_menu = true
		Global.highscore_loaded = false
	# If game is paused and a menu button is not selected and we are in the menu
	# then grab focus (select) the "restart" button
	# Focus is now grabbed (a menu button is selected)
	if get_tree().paused and !focus_grabbed and in_you_win_menu:
		$VBoxContainer/MainMenuButton.grab_focus()
		focus_grabbed = true

func _on_MainMenuButton_pressed():
	if get_tree().paused:
		visible = false
		in_you_win_menu = false
		focus_grabbed = false
		get_tree().paused = false
		Global.in_main_menu = true
		var select_sound = select_sound_scene.instance()
		SelectSoundParent.add_child(select_sound)

# When "restart" button is pressed, hide the menu and restart current level
func _on_RestartButton_pressed():
	if get_tree().paused:
		var _restart = get_tree().reload_current_scene()
		get_tree().paused = false
		focus_grabbed = false
		in_you_win_menu = false
		var select_sound = select_sound_scene.instance()
		SelectSoundParent.add_child(select_sound)


func _on_Button_focus_exited():
	var change_focus = change_focus_sound.instance()
	add_child(change_focus)
