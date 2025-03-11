extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var is_facing_right = true
@onready var animated_sprite = $Sprite2D

var score = 0
@onready var score_text : Label = get_node("CanvasLayer/Label")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if (Input.is_action_just_pressed("ui_accept") and is_on_floor()):
		velocity.y = JUMP_VELOCITY
	if (Input.is_action_just_pressed("ui_up") and is_on_floor()):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if (is_facing_right and velocity.x < 0) or ( not is_facing_right and velocity.x > 0):
		scale.x *= -1
		is_facing_right = not is_facing_right
	
	if (global_position.y > 280):
		game_over()
	
	update_animations()

	move_and_slide()

func update_animations():
	
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
		return
	
	if velocity.x:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")

func game_over():
	get_tree().reload_current_scene()


func add_score():
	score += 1
	score_text.text = str("Craneos: ", score)
