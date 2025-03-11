extends Button

@export_file("*.tscn") var main_scene 

func _ready():
	self.connect("pressed", _on_pressed)

func _on_pressed():
	_restart_game() 

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_restart_game()

func _restart_game():
	if main_scene:
		get_tree().change_scene_to_file(main_scene)
