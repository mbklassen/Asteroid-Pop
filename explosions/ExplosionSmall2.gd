extends AnimatedSprite


func _ready():
	playing = true
	Global.boss_explosion_finished = false

func _process(_delta):
	if frame == 6:
		Global.boss_explosion_finished = true
		queue_free()
