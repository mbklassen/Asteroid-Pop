extends Node2D

var level_scene = load("res://levels/level" + str(Global.level) + "/Level" + str(Global.level) + ".tscn")
var player_scene = load("res://player/Player.tscn")

func _ready():
	var current_level = level_scene.instance()
	add_child(current_level)
	
	var player = player_scene.instance()
	add_child(player)
	player.position = Vector2((get_viewport_rect().size.x/2), (get_viewport_rect().size.y - 100))
