extends Area2D

@export_file("*.tscn") var next_scene  # Escena del siguiente nivel
@onready var animated_sprite = $puerta # Referencia al sprite animado

func _ready():
	animated_sprite.play("close") 

func _process(_delta):
	var player = get_tree().get_first_node_in_group("player")
	if player.score >= 3:
		animated_sprite.play("open")

func _on_body_entered(body):
	if body.is_in_group("player"):
		if body.score >= 3:
			get_tree().change_scene_to_file(next_scene)
