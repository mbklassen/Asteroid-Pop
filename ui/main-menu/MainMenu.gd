extends Control

var change_focus_sound = preload("res://sounds/audio-stream-players/UIChange.tscn")
var select_sound_scene = preload("res://sounds/audio-stream-players/UISelect.tscn")

const SAVE_FILE_PATH_LEVEL1 = "user://level1_highscore.save"
const SAVE_FILE_PATH_LEVEL2 = "user://level2_highscore.save"
const SAVE_FILE_PATH_LEVEL3 = "user://level3_highscore.save"

var focus_grabbed = false

func _process(_delta):
	# If menu is visible then we are now in the menu
	if Global.in_main_menu and !get_tree().paused:
		visible = true
		get_tree().paused = true
		if Global.boss_level:
			Global.boss_music_playing = false
			Global.new_music_started = true
	# If game is paused and a menu button is not selected and we are in the menu
	# then grab focus (select) the "level 1" button
	# Focus is now grabbed (a menu button is selected)
	if get_tree().paused and !focus_grabbed and Global.in_main_menu:
		$HBoxContainer/Level1Button.grab_focus()
		focus_grabbed = true
		
	var save_data = File.new()
	if !Global.level1_complete and save_data.file_exists(SAVE_FILE_PATH_LEVEL1):
		Global.level1_complete = true
	if !Global.level2_complete and save_data.file_exists(SAVE_FILE_PATH_LEVEL2):
		Global.level2_complete = true
	if !Global.level3_complete and save_data.file_exists(SAVE_FILE_PATH_LEVEL3):
		Global.level3_complete = true

func _on_Level1Button_pressed():
	if get_tree().paused:
		_close_menu()
		Global.level = 1

func _on_Level2Button_pressed():
	if get_tree().paused:
		_close_menu()
		Global.level = 2

func _on_Level3Button_pressed():
	if get_tree().paused:
		_close_menu()
		Global.level = 3

func _on_Level4Button_pressed():
	if get_tree().paused:
		_close_menu()
		Global.level = 4
		
func _close_menu():
	get_tree().paused = false
	focus_grabbed = false
	Global.in_main_menu = false
	visible = false
	var select_sound = select_sound_scene.instance()
	SelectSoundParent.add_child(select_sound)
	var _restart = get_tree().reload_current_scene()

func _on_Button_focus_exited():
	var change_focus = change_focus_sound.instance()
	add_child(change_focus)
