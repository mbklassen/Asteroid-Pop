extends Node2D


var level_scene
var level_x
var current_level

func _ready():
	current_level = Global.level
	# Load current level scene, based on the value stored in current_level (Global.level)
	level_scene = load("res://levels/level" + str(current_level) + "/Level" + str(current_level) + ".tscn")
	# Instantiate the current level (same as Global.level) and add it as a child of the world node
	level_x = level_scene.instance()
	add_child(level_x)
	
func _process(_delta):
	# If Global.level differs from current_level, it means we have entered a new level
	# If this is the case and we are not on the final level, then delete the current level and load the next level
	if current_level != Global.level and !Global.final_level:
		current_level = Global.level
		# For each child of world, if that child is a level then queue that node to be freed
		for child in get_children():
			if child.is_in_group("levels"):
				child.queue_free()
		level_scene = load("res://levels/level" + str(current_level) + "/Level" + str(current_level) + ".tscn")
		# Instantiate the current level (same as Global.level) and add it as a child of the world node
		level_x = level_scene.instance()
		add_child(level_x)

func _input(event):
	
	# !!! TO BE REMOVED ON COMPLETION OF TESTING !!!
	# When next_level button/key is pressed, and game is not paused and we are not on the final level, go to next level
	if event.is_action_pressed("next_level") and !Global.final_level and !Global.game_paused:
		# For each child of world, if that child is a level then queue that node to be freed
		for child in get_children():
			if child.is_in_group("levels"):
				child.queue_free()
		level_scene = load("res://levels/level" + str(current_level + 1) + "/Level" + str(current_level + 1) + ".tscn")
		# Instantiate the next level and add it as a child of the world node
		level_x = level_scene.instance()
		add_child(level_x)
		# Newly created level node changes Global.level, so current_level needs to be set to it
		current_level = Global.level
	
	# !!! TO BE REMOVED ON COMPLETION OF TESTING !!!
	# When prev_level button/key is pressed, and game is not paused and we are not on the first level, go to previous level
	if event.is_action_pressed("prev_level") and !Global.first_level and !Global.game_paused:
		# For each child of world, if that child is a level then queue that node to be freed
		for child in get_children():
			if child.is_in_group("levels"):
				child.queue_free()
		level_scene = load("res://levels/level" + str(current_level - 1) + "/Level" + str(current_level - 1) + ".tscn")
		# Instantiate the previous level and add it as a child of the world node
		level_x = level_scene.instance()
		add_child(level_x)
		# Newly created level node changes Global.level, so current_level needs to be set to it
		current_level = Global.level
