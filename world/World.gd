extends Node2D

# Load current level scene, based on the value stored in Global.level
var level_scene = load("res://levels/level" + str(Global.level) + "/Level" + str(Global.level) + ".tscn")

var level_x
var current_level

func _ready():
	# Instantiate the current level and add it as a child of the world node
	level_x = level_scene.instance()
	add_child(level_x)
	current_level = Global.level


func _process(_delta):
	if current_level != Global.level and get_node_or_null("Level" + str(Global.level)) != null:
		level_x.queue_free()
		level_scene = load("res://levels/level" + str(Global.level) + "/Level" + str(Global.level) + ".tscn")
		level_x = level_scene.instance()
		current_level = Global.level
		print(current_level)
