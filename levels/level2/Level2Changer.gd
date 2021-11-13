extends Node


func _input(event):
	if event.is_action_pressed("prev_level"):
		var _goto_prev_level = get_tree().change_scene("res://levels/level1/Level1.tscn")
