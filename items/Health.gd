extends RigidBody2D


func _on_Health_body_entered(body):
	if body.name == "Player":
		Global.item_health_acquired = true
		queue_free()
