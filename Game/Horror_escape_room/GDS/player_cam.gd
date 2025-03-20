extends Camera2D
@onready var player: CharacterBody2D = $"../Player"
@onready var player_cam: Camera2D = $"."


func _physics_process(delta: float) -> void:
	player_cam.position.x = player.position.x
