
extends Control

var change_focus_sound = preload("res://sounds/audio-stream-players/UIChange.tscn")
var select_sound_scene = preload("res://sounds/audio-stream-players/UISelect.tscn")

var focus_grabbed = false
var in_level_end_menu = false

func _process(_delta):
	# If menu is visible then we are now in the menu
	if visible and !in_level_end_menu:
		in_level_end_menu = true
		Global.highscore_loaded = false
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
		var select_sound = select_sound_scene.instance()
		SelectSoundParent.add_child(select_sound)
		
func _on_MainMenuButton_pressed():
	if get_tree().paused:
		visible = false
		in_level_end_menu = false
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
		in_level_end_menu = false
		var select_sound = select_sound_scene.instance()
		SelectSoundParent.add_child(select_sound)

func _on_Button_focus_exited():
	var change_focus = change_focus_sound.instance()
	add_child(change_focus)
