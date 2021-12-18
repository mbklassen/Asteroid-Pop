extends RigidBody2D


# If player collides with health item, then health has been acquired
# Queue health item node to be freed
func _on_Health_body_entered(body):
	if body.name == "Player":
		Global.item_health_acquired = true
		queue_free()
