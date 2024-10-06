extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("attack_side")


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
	$AnimatedSprite2D.play("death")
	playDeathNoise()
	await get_tree().create_timer(0.5).timeout
	hide()
	queue_free()
