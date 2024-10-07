extends CanvasLayer
signal restart_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("start_game"):
		restart_game.emit()

func activate():
	show()
	$Music.play()

func mute():
	hide()
	$Music.stop()
