extends Node2D

# Load current level scene, based on the value stored in Global.level
var level1_scene
var level1
var current_level

func _ready():
	current_level = Global.level
	level1_scene = load("res://levels/level" + str(current_level) + "/Level" + str(current_level) + ".tscn")
	# Instantiate the current level and add it as a child of the world node
	level1 = level1_scene.instance()
	add_child(level1)

func _process(_delta):
	if current_level != Global.level and !Global.final_level:
		for child in get_children():
			if child.is_in_group("levels"):
				print("level deleted ahhh fuck")
				child.queue_free()
		current_level = Global.level
		var level_scene = load("res://levels/level" + str(current_level) + "/Level" + str(current_level) + ".tscn")
		var level_x = level_scene.instance()
		add_child(level_x)
		
	if Input.is_action_just_pressed("next_level") and !Global.final_level:
		for child in get_children():
			if child.is_in_group("levels"):
				print("level deleted")
				child.queue_free()
		current_level += 1
		var prev_level_scene = load("res://levels/level" + str(current_level) + "/Level" + str(current_level) + ".tscn")
		var prev_level_x = prev_level_scene.instance()
		add_child(prev_level_x)
	
	if Input.is_action_just_pressed("prev_level") and !Global.first_level:
		for child in get_children():
			if child.is_in_group("levels"):
				print("level deleted")
				child.queue_free()
		current_level -= 1
		var next_level_scene = load("res://levels/level" + str(current_level) + "/Level" + str(current_level) + ".tscn")
		var next_level_x = next_level_scene.instance()
		add_child(next_level_x)
