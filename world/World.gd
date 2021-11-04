extends Node2D

# load current level scene, based on the value stored in Global.level
var level_scene = load("res://levels/level" + str(Global.level) + "/Level" + str(Global.level) + ".tscn")

func _ready():
	# instantiate the current level and add it as a child of the world node
	var current_level = level_scene.instance()
	add_child(current_level)
