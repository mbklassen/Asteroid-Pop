extends AnimatedSprite


func _ready():
	playing = true

func _process(_delta):
	if frame == 7:
		queue_free()
