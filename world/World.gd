extends Node2D

# Load current level scene, based on the value stored in Global.level
var level_scene
var level_x
var current_level

func _ready():
	level_scene = load("res://levels/level" + str(Global.level) + "/Level" + str(Global.level) + ".tscn")
	# Instantiate the current level and add it as a child of the world node
	level_x = level_scene.instance()
	add_child(level_x)
	current_level = Global.level

func _input(event):
	if event.is_action_pressed("ui_page_up") and !Global.final_level:
		Global.level += 1
		level_scene = load("res://levels/level" + str(Global.level) + "/Level" + str(Global.level) + ".tscn")
		get_node("Level" + str(current_level)).queue_free()
		level_x = level_scene.instance()
		add_child(level_x)
		current_level = Global.level
	if event.is_action_pressed("ui_page_down") and !Global.first_level:
		Global.level -= 1
		level_scene = load("res://levels/level" + str(Global.level) + "/Level" + str(Global.level) + ".tscn")
		get_node("Level" + str(current_level)).queue_free()
		level_x = level_scene.instance()
		add_child(level_x)
		current_level = Global.level

func _process(_delta):
	print(current_level)
	if current_level != Global.level and !Global.final_level:
		level_scene = load("res://levels/level" + str(Global.level) + "/Level" + str(Global.level) + ".tscn")
		get_node("Level" + str(current_level)).queue_free()
		level_x = level_scene.instance()
		add_child(level_x)
		current_level = Global.level
		print(current_level)
