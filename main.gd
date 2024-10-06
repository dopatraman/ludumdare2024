extends Node

@export var roach_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over():
	$Music.stop()
	$StartScreen.show_game_over()

func new_game():
	score = 0
	$Music.play()
	$StartPosition.position = get_viewport().size / 2
	$Rat.start($StartPosition.position)
	$StartScreen.show_message("Get Ready!")
	$RoachTimer.start()
	get_tree().call_group("roaches", "queue_free")


func _on_start_screen_start_game() -> void:
	new_game()


func _on_roach_timer_timeout() -> void:
	var roach = roach_scene.instantiate()

	# Choose a random location on Path2D.
	var roach_spawn_location = $RoachPath/RoachSpawnLocation
	roach_spawn_location.progress_ratio = randf()

	# Set the roach's direction perpendicular to the path direction.
	var direction = roach_spawn_location.rotation + PI / 2

	# Set the roach's position to a random location.
	roach.position = roach_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	roach.rotation = direction

	# Choose the velocity for the roach.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	roach.linear_velocity = velocity.rotated(direction)

	# Spawn the roach by adding it to the Main scene.
	add_child(roach)
