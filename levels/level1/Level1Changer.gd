extends Node


func _input(event):
	if event.is_action_pressed("next_level"):
		var _goto_next_level = get_tree().change_scene("res://levels/level2/Level2.tscn")
