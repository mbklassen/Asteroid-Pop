extends RigidBody2D

const HP_VALUE = 20
const DROP_POTENTIAL = 0.3

var explosion_scene = preload("res://particles/Explosion.tscn")
var explosion_color = Color(0.63, 0, 0, 1)

var drop_value = rand_range(0, 1)
var item_shoot_faster = preload("res://items/ShootFaster.tscn")
var item_list = [item_shoot_faster]

var will_drop_item


func _ready():
	if drop_value < DROP_POTENTIAL:
		will_drop_item = true
	else:
		will_drop_item = false

func _on_Enemy1_body_entered(body):
	# Instantiate Explosion node
	var explosion = explosion_scene.instance()
	# Get parent of current node (World) and store it in level_root
	explosion.global_position = global_position
	# Set explosion colour to be same as asteroid's
	explosion.process_material.color = explosion_color
	# Explosion particles are now emitting
	explosion.emitting = true
	# Get World node
	var level_node = get_parent()
	# Add child of level node (so it is a sibling to Asteroid)
	level_node.add_child(explosion)
	
	if body.name == "Player":
		Global.hp -= HP_VALUE
	else:
		if will_drop_item:
			var item = item_list[randi() % item_list.size()].instance()
			item.global_position = global_position
			level_node.call_deferred("add_child", item)
	queue_free()
