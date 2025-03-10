extends Area2D
@export var move_speed = 300
@export var move_dir : Vector2

var start_position : Vector2
var target_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = global_position
	target_position = start_position + move_dir


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = global_position.move_toward(target_position, move_speed * delta)
	
	if global_position == target_position:
		if global_position == start_position:
			target_position = start_position + move_dir
		else: 
			target_position = start_position
	


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.game_over()
