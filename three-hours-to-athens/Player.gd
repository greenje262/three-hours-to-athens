extends AnimatedSprite

const AIR_TIME = 0.35

signal ouch

func _physics_process(delta):
	if Input.is_action_just_pressed("jamp") && $JumpTween.is_active() == false:
		
		play("jump")
		
		$JumpTween.interpolate_property(self, "position", position, Vector2(position.x, position.y - 64), AIR_TIME, Tween.TRANS_QUAD, Tween.EASE_OUT)
		$JumpTween.start()
		
		yield(get_tree().create_timer(AIR_TIME), "timeout")
		
		play("fall")
		
		$JumpTween.interpolate_property(self, "position", position, Vector2(position.x, position.y + 64), AIR_TIME, Tween.TRANS_QUAD, Tween.EASE_IN)
		$JumpTween.start()
		
		yield(get_tree().create_timer(AIR_TIME), "timeout")
		
		play("run")


func _on_Area2D_body_entered(body):
	emit_signal("ouch")
	stop()
