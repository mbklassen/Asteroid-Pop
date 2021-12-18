extends RigidBody2D


# If player collides with shoot faster item, then shoot faster has been acquired
# Queue shoot faster item node to be freed
func _on_ShootFaster_body_entered(body):
	if body.name == "Player":
		Global.item_shoot_faster_acquired = true
		queue_free()
