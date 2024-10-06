extends Node

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


func _on_start_screen_start_game() -> void:
	new_game()
