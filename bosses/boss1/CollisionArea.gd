####### This node/script is needed to handle collision for this kinematic body #######

extends Area2D


var explosion_scene = preload("res://particles/BossExplosion.tscn")
var damage_sound_scene = preload("res://sounds/audio-stream-players/BossDamage.tscn")
var explosion_color = Color(0.8, 0.55, 0.1, 1)

var boss
var level_node

func _ready():
	# Get boss node
	boss = get_parent()
	# Get current level node
	level_node = get_parent().get_parent()
	
func _on_CollisionArea_body_entered(_body):
	# Instantiate damage sound, when boss is hit by player's bullet
	var damage_sound = damage_sound_scene.instance()
	level_node.add_child(damage_sound)
	
	# Instantiate explosion particle node (sparks) when hit
	var explosion = explosion_scene.instance()
	# Set position of sparks to be boss's current position
	explosion.global_position = global_position
	# Set colour to be same as asteroid's
	explosion.process_material.color = explosion_color
	# Explosion particles are now emitting
	explosion.emitting = true
	# Add explosion particles as child of current level
	level_node.add_child(explosion)
