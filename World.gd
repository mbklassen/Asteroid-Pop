extends Node2D


var level_scene = preload("res://levels/base-level/BaseLevel.tscn")

func _ready():
	var level = level_scene.instance()
	add_child(level)
