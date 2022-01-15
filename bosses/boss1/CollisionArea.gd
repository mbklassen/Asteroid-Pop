extends Area2D


# This node/script is needed to handle collision for this kinematic body

var explosion_scene = preload("res://particles/BossExplosion.tscn")
var damage_sound_scene = preload("res://sounds/audio-stream-players/BossDamage.tscn")
var explosion_color = Color(0.63, 0, 0, 1)

var boss
var level_node

func _ready():
	boss = get_parent()
	level_node = get_parent().get_parent()
	
func _on_CollisionArea_body_entered(_body):
	var damage_sound = damage_sound_scene.instance()
	level_node.add_child(damage_sound)
	# Instantiate Explosion node
	var explosion = explosion_scene.instance()
	# Get parent of current node (World) and store it in level_root
	explosion.global_position = global_position
	# Set explosion colour to be same as asteroid's
	explosion.process_material.color = explosion_color
	# Explosion particles are now emitting
	explosion.emitting = true
	# Add child of level node (so it is a sibling to Asteroid)
	level_node.add_child(explosion)
