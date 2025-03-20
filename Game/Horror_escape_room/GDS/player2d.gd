extends CharacterBody2D

var SPEED = 100.0
@onready var player_anim: AnimationPlayer = $AnimationPlayer
@onready var player_sprite: Sprite2D = $player_sprite

func _physics_process(delta: float) -> void:


	if Input.is_action_just_pressed("left"):
		player_sprite.flip_h = true
	elif Input.is_action_just_pressed("right"):
		player_sprite.flip_h = false

	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = direction * SPEED
		player_anim.play("move")
	else:
		player_anim.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
