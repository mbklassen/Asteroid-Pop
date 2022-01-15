extends RigidBody2D

var item_pickup_sound_scene = preload("res://sounds/audio-stream-players/ItemPickup.tscn")

onready var level_node = get_parent()

# If player collides with health item, then health has been acquired
# Queue health item node to be freed
func _on_Health_body_entered(body):
	if body.name == "Player":
		Global.item_health_acquired = true
		var item_pickup_sound = item_pickup_sound_scene.instance()
		level_node.add_child(item_pickup_sound)
		queue_free()
