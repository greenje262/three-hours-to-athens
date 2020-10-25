extends RigidBody2D

func _ready():
	var obst_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = obst_types[randi() % obst_types.size()]

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
