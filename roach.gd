extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func playDeathNoise():
	var rng = randi_range(0,2)
	match rng:
		0:
			$death1.play()
		1:
			$death2.play()
		2:
			$death3.play()

func playAttackNoise():
	var rng = randi_range(0,1)
	match rng:
		0:
			$attack1.play()
		1:
			$attack2.play()
		
func death():
	$AnimatedSprite2D.animation = "death"
	$AnimatedSprite2D.play()
	playDeathNoise()
	await get_tree().create_timer(0.5).timeout
	hide()
	queue_free()

func point_down():
	$AnimatedSprite2D.animation = "attack_down"
	$AnimatedSprite2D.play()

func point_up():
	$AnimatedSprite2D.animation = "attack_up"
	$AnimatedSprite2D.play()

func point_right():
	$AnimatedSprite2D.flip_h = false
	$AnimatedSprite2D.animation = "attack_side"
	$AnimatedSprite2D.play()

func point_left():
	$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.animation = "attack_side"
	$AnimatedSprite2D.play()
