extends Node2D

# Load current level scene, based on the value stored in Global.level
var level_scene
var level_x
var current_level

func _ready():
	current_level = Global.level
	level_scene = load("res://levels/level" + str(current_level) + "/Level" + str(current_level) + ".tscn")
	# Instantiate the current level and add it as a child of the world node
	level_x = level_scene.instance()
	add_child(level_x)

func _process(_delta):
	if current_level != Global.level and !Global.final_level:
		for child in get_children():
			if child.is_in_group("levels"):
				child.queue_free()
		current_level = Global.level
		level_scene = load("res://levels/level" + str(current_level) + "/Level" + str(current_level) + ".tscn")
		level_x = level_scene.instance()
		add_child(level_x)
		
	if Input.is_action_just_pressed("next_level") and !Global.final_level:
		for child in get_children():
			if child.is_in_group("levels"):
				child.queue_free()
		current_level += 1
		level_scene = load("res://levels/level" + str(current_level) + "/Level" + str(current_level) + ".tscn")
		level_x = level_scene.instance()
		add_child(level_x)
	
	
	if Input.is_action_just_pressed("prev_level") and !Global.first_level:
		for child in get_children():
			if child.is_in_group("levels"):
				child.queue_free()
		current_level -= 1
		level_scene = load("res://levels/level" + str(current_level) + "/Level" + str(current_level) + ".tscn")
		level_x = level_scene.instance()
		add_child(level_x)
