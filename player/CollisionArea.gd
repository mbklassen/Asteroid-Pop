extends Area2D


var explosion_scene = preload("res://particles/PlayerExplosion.tscn")
var being_hit = false

var player
var hit_effect_timer
var explosion_color


func _ready():
	player = get_parent()
	hit_effect_timer = $HitEffectTimer


func _on_CollisionArea_body_entered(_body):
	if !being_hit:
		being_hit = true
		player.modulate = Color(0.5, 0.5, 0.5)
		
		# Instantiate Explosion node
		var explosion = explosion_scene.instance()
		# Get parent of current node (World) and store it in level_root
		explosion.global_position = global_position
		# Set explosion colour to be same as asteroid's
		explosion_color = Color(0.3, 0.7, 0.95, 1)
		explosion.process_material.color = explosion_color
		# Explosion particles are now emitting
		explosion.emitting = true
		# Get World node
		var level_node = get_parent().get_parent()
		# Add child of level node (so it is a sibling to Asteroid)
		level_node.add_child(explosion)
		
		hit_effect_timer.wait_time = 0.13
		hit_effect_timer.start()

func _on_HitEffectTimer_timeout():
	being_hit = false
	player.modulate = Color(1, 1, 1)
