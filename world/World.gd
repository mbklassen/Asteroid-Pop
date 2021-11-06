extends Node2D

# load current level scene, based on the value stored in Global.level
var level_scene = load("res://levels/level" + str(Global.level) + "/Level" + str(Global.level) + ".tscn")

var current_level
var level

func _ready():
	# instantiate the current level and add it as a child of the world node
	current_level = level_scene.instance()
	add_child(current_level)
	level = Global.level


func _process(_delta):
	if level != Global.level:
		current_level.queue_free()
		level_scene = load("res://levels/level" + str(Global.level) + "/Level" + str(Global.level) + ".tscn")
		current_level = level_scene.instance()
		level = Global.level
