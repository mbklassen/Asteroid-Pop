extends Area2D


var explosion_scene = preload("res://particles/BossExplosion.tscn")
var explosion_color = Color(0.63, 0, 0, 1)
var being_hit = false

var boss
var hit_effect_timer

func _ready():
	boss = get_parent()
	hit_effect_timer = $HitEffectTimer

func _on_CollisionArea_body_entered(_body):
	if !being_hit and !Global.boss1_charging_up:
		being_hit = true
		boss.modulate = Color(1, 1, 1)
		
		# Instantiate Explosion node
		var explosion = explosion_scene.instance()
		# Get parent of current node (World) and store it in level_root
		explosion.global_position = global_position
		# Set explosion colour to be same as asteroid's
		explosion.process_material.color = explosion_color
		# Explosion particles are now emitting
		explosion.emitting = true
		# Get World node
		var level_node = get_parent().get_parent()
		# Add child of level node (so it is a sibling to Asteroid)
		level_node.add_child(explosion)
		
		hit_effect_timer.wait_time = 0.125
		hit_effect_timer.start()

func _on_HitEffectTimer_timeout():
	being_hit = false
	boss.modulate = Color(1.5, 1.5, 1.5)
