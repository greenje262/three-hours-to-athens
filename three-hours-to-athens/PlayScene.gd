extends Node2D

const OBST = preload("res://Obstacle.tscn")

onready var distance = 0
onready var obst = OBST.instance()

func _ready():
	randomize()
	$Player.connect("ouch", self, "ouch")

func _process(delta):
	if distance < 26.2:
		$ParallaxBackground.scroll_offset.x -= 150 * delta
		$ResetButton.hide()

func _on_Chrono_timeout():
	if distance > 26.2:
		sunset()
		$Chrono.stop()
		$DistanceText.text = "NIKE!!!"
	else:
		distance += 0.1
		$DistanceText.text = "Distance: " + str(distance) + " miles"

func _on_ObstTimer_timeout():
	if distance < 26.1:
		obst = OBST.instance()
		add_child(obst)
		obst.position = Vector2(250, 96)
		obst.linear_velocity = Vector2(-150, 0)
		$ObstTimer.wait_time = 2 + rand_range(-1, 0.5)
	else:
		$ObstTimer.stop()

func start():
	var obst = OBST.instance()
	distance = 0
	$PlayButton.hide()
	$ResetButton.hide()
	start_text()
	$Player.play()
	$Player/PlayerTween.interpolate_property($Player, "position", $Player.position, Vector2(26.2, 92), 1)
	$Player/PlayerTween.start()
	yield(get_tree().create_timer(2), "timeout")
	$Chrono.start()
	$ObstTimer.start()

func ouch():
	$DistanceText.text = "Ouch!"
	$Chrono.stop()
	$ObstTimer.stop()
	distance = 300
	$Player/PlayerTween.interpolate_property($Player, "position", $Player.position, Vector2(-123.8, 92), 1)
	$Player/PlayerTween.start()
	yield(get_tree().create_timer(1), "timeout")
	$ResetButton.show()

func sunset():
	if $Player/JumpTween.is_active() == false:
		$Player/JumpTween.interpolate_property($Player, "position", $Player.position, Vector2(300, 92), 3)
		$Player/JumpTween.start()
		yield(get_tree().create_timer(4), "timeout")
		$ResetButton.show()

func start_text():
	$DistanceText.text = "Ready..."
	yield(get_tree().create_timer(1), "timeout")
	$DistanceText.text = "Start!!"
	yield(get_tree().create_timer(1), "timeout")
	$DistanceText.text = "Distance: " + str(distance) + " miles"

func _on_PlayButton_pressed():
	start()

func _on_ResetButton_pressed():
	start()
