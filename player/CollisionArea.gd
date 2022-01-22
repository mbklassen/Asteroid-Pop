####### This node/script is needed to handle collision for this kinematic body #######

extends Area2D


var explosion_scene = preload("res://particles/PlayerExplosion.tscn")
var damage_sound_scene = preload("res://sounds/audio-stream-players/PlayerDamage.tscn")
var being_hit = false

var player
var player_sprite
var hit_effect_timer
var explosion_color
var level_node


func _ready():
	player = get_parent()
	player_sprite = player.get_node("Sprite")
	hit_effect_timer = $HitEffectTimer
	level_node = get_parent().get_parent()

func _on_CollisionArea_body_entered(_body):
	if !being_hit:
		var damage_sound = damage_sound_scene.instance()
		level_node.add_child(damage_sound)
		
		# Change color of ship briefly when hit
		being_hit = true
		player_sprite.self_modulate = Color(0.5, 0.5, 0.5)
		
		# Instantiate Explosion node
		var explosion = explosion_scene.instance()
		explosion.global_position = global_position
		# Set explosion colour to be same as asteroid's
		explosion_color = Color(0.3, 0.7, 0.95, 1)
		explosion.process_material.color = explosion_color
		# Explosion particles are now emitting
		explosion.emitting = true
		# Add explosion as a child of current level
		level_node.add_child(explosion)
		
		hit_effect_timer.wait_time = 0.13
		hit_effect_timer.start()

# After a brief delay, change ship color back to original
func _on_HitEffectTimer_timeout():
	being_hit = false
	player_sprite.self_modulate = Color(1, 1, 1)
