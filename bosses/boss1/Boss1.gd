extends KinematicBody2D

var death_explosion_scene1 = preload("res://explosions/ExplosionSmall1.tscn")
var death_explosion_scene2 = preload("res://explosions/ExplosionSmall2.tscn")
var death_explosion_scene3 = preload("res://explosions/ExplosionSmall3.tscn")
var death_explosion_scene4 = preload("res://explosions/ExplosionBig.tscn")

var explosion_sound_scene = preload("res://sounds/audio-stream-players/Explosion1.tscn")
var final_explosion_sound_scene = preload("res://sounds/audio-stream-players/Explosion2.tscn")

var explosion1_started = false
var explosion2_started = false
var explosion3_started = false
var explosion4_started = false

onready var level_node = get_parent()

func _process(_delta):
	if Global.boss1_hp <= 0 and !explosion1_started:
		self.remove_child($States)
		self.remove_child($CollisionArea)
		$Sprite.self_modulate = Color(1.5, 1.5, 1.5)
		var explosion1 = death_explosion_scene1.instance()
		explosion1.global_position = $ExplosionPositions/Explosion1.global_position
		level_node.add_child(explosion1)
		explosion1_started = true
		var explosion_sound = explosion_sound_scene.instance()
		level_node.add_child(explosion_sound)
	if explosion1_started and !explosion2_started and Global.boss_explosion_finished:
		var explosion2 = death_explosion_scene2.instance()
		explosion2.global_position = $ExplosionPositions/Explosion2.global_position
		level_node.add_child(explosion2)
		explosion2_started = true
		var explosion_sound = explosion_sound_scene.instance()
		level_node.add_child(explosion_sound)
	if explosion2_started and !explosion3_started and Global.boss_explosion_finished:
		var explosion3 = death_explosion_scene3.instance()
		explosion3.global_position = $ExplosionPositions/Explosion3.global_position
		level_node.add_child(explosion3)
		explosion3_started = true
		var explosion_sound = explosion_sound_scene.instance()
		level_node.add_child(explosion_sound)
	if explosion3_started and !explosion4_started and Global.boss_explosion_finished:
		var explosion4 = death_explosion_scene4.instance()
		explosion4.global_position = global_position
		level_node.add_child(explosion4)
		explosion4_started = true
		var final_explosion_sound = final_explosion_sound_scene.instance()
		level_node.add_child(final_explosion_sound)
		Global.boss_dead = true
