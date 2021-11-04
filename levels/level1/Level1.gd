extends Node2D


# load the player scene
var player_scene = load("res://player/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# instantiate the player and add it as a child of the current level
	var player = player_scene.instance()
	add_child(player)

