extends RigidBody2D


func _on_ShootFaster_body_entered(body):
	if body.name == "Player":
		Global.item_shoot_faster_acquired = true
		queue_free()
