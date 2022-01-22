extends KinematicBody2D

# Preloads three different small explosions to be instantiated on boss's death
var death_explosion_scene1 = preload("res://explosions/ExplosionSmall1.tscn")
var death_explosion_scene2 = preload("res://explosions/ExplosionSmall2.tscn")
var death_explosion_scene3 = preload("res://explosions/ExplosionSmall3.tscn")
# Preloads a final large explosion to be instantiated on boss death
var death_explosion_scene4 = preload("res://explosions/ExplosionBig.tscn")

# Preloads explosion sounds
var explosion_sound_scene = preload("res://sounds/audio-stream-players/Explosion1.tscn")
var final_explosion_sound_scene = preload("res://sounds/audio-stream-players/Explosion2.tscn")

var explosion1_started = false
var explosion2_started = false
var explosion3_started = false
var explosion4_started = false

# Get the current level
onready var level_node = get_parent()

func _process(_delta):
	# If boss's hp has reached zero and the first explosion has not started 
	# Then create first explosion
	if Global.boss1_hp <= 0 and !explosion1_started:
		# Remove the boss's State and CollisionArea nodes
		# This is to prevent boss from moving and shooting while explosion animations are being played
		# Also prevents the boss from emitting sparks (explosion particles) if hit with additional bullets
		self.remove_child($States)
		self.remove_child($CollisionArea)
		# Sets boss's modulation colour to normal, in case it was charging super shots when it died
		# (boss flashes brighter twice when charging up super shots)
		$Sprite.self_modulate = Color(1.5, 1.5, 1.5)
		
		# Instantiate first explosion and set its position
		var explosion1 = death_explosion_scene1.instance()
		explosion1.global_position = $ExplosionPositions/Explosion1.global_position
		# Add it as a child of the current level
		level_node.add_child(explosion1)
		
		explosion1_started = true
		
		# Instantiate small explosion sound and add it as a child of current level
		var explosion_sound = explosion_sound_scene.instance()
		level_node.add_child(explosion_sound)
	
	# If first explosion has started and second explosion has not started
	# And ExplosionSmall1 node has set the global variable, boss_explosion_finished, to be true
	# Then create the second explosion
	if explosion1_started and !explosion2_started and Global.boss_explosion_finished:
		# Instantiate second explosion and set its position
		var explosion2 = death_explosion_scene2.instance()
		explosion2.global_position = $ExplosionPositions/Explosion2.global_position
		level_node.add_child(explosion2)
		
		explosion2_started = true
		
		# Instantiate small explosion sound and add it as a child of current level
		var explosion_sound = explosion_sound_scene.instance()
		level_node.add_child(explosion_sound)
		
	# If second explosion has started and third explosion has not started
	# And ExplosionSmall2 node has set the global variable, boss_explosion_finished, to be true
	# Then create the third explosion
	if explosion2_started and !explosion3_started and Global.boss_explosion_finished:
		# Instantiate third explosion and set its position
		var explosion3 = death_explosion_scene3.instance()
		explosion3.global_position = $ExplosionPositions/Explosion3.global_position
		level_node.add_child(explosion3)
		
		explosion3_started = true
		
		# Instantiate small explosion sound and add it as a child of current level
		var explosion_sound = explosion_sound_scene.instance()
		level_node.add_child(explosion_sound)
	
	# If third explosion has started and fourth explosion has not started
	# And ExplosionSmall3 node has set the global variable, boss_explosion_finished, to be true
	# Then create the fourth (and final) explosion
	if explosion3_started and !explosion4_started and Global.boss_explosion_finished:
		# Instantiate fourth explosion and set its position
		var explosion4 = death_explosion_scene4.instance()
		explosion4.global_position = global_position
		level_node.add_child(explosion4)
		
		explosion4_started = true
		
		# Instantiate lasrger explosion sound and add it as a child of current level
		var final_explosion_sound = final_explosion_sound_scene.instance()
		level_node.add_child(final_explosion_sound)
		
		# Signals Level4 node to delete this boss node and start level_end_timer
		# (level_end_timer allows time for all enemies to leave the screen before ending the level)
		Global.boss_dead = true
