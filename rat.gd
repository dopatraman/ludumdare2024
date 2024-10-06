extends Area2D
signal death
signal kills

@export var speed = 800 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var is_dead = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_dead = false
	hide()
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()

func playRatAttackNoise():
	var rng = randi_range(0,2)
	match rng:
		0:
			$"SwordSwing-1".play()
		1:
			$"SwordSwing-2".play()
		2:
			$"SwordSwing-3".play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dead:
		return

	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		if not $"Walking-1".is_playing():
			$"Walking-1".play()
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		if not $"Walking-2".is_playing():
			$"Walking-2".play()
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		if not $"Walking-3".is_playing():
			$"Walking-3".play()
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		if not $"Walking-3".is_playing():
			$"Walking-3".play()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if Input.is_action_pressed("attack") && Input.is_action_pressed("move_down"):
			$AnimatedSprite2D.animation = "attack_down"
			$AnimatedSprite2D.play()
		elif Input.is_action_pressed("attack") && Input.is_action_pressed("move_up"):
			$AnimatedSprite2D.animation = "attack_up"
			$AnimatedSprite2D.play()
		elif Input.is_action_pressed("attack"):
			$AnimatedSprite2D.animation = "attack_side"
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.animation = "run"
			$AnimatedSprite2D.play()
	elif Input.is_action_pressed("attack"):
		$AnimatedSprite2D.animation = "attack_side"
		$AnimatedSprite2D.play()
		playRatAttackNoise()
	else:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0


func _on_body_entered(body: Node2D) -> void:
	if Input.is_action_pressed("attack"):
		rat_kills(body)
		$"RatHitRoach-1".play()
	else:
		rat_dies()
		

func rat_dies():
	is_dead = true
	$AnimatedSprite2D.animation = "death"
	$AnimatedSprite2D.play()
	$"RatKO-1".play()
	death.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D.stop()
	hide()

func rat_kills(body: Node2D):
	is_dead = false
	kills.emit(body)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	is_dead = false
