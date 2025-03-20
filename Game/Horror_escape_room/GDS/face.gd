extends Sprite2D

@onready var face: Sprite2D = $"."
@export var timer: Timer


func _ready() -> void:
	face.visible = false

func _on_timer_timeout() -> void:
	var chance = randi() % 100
	if chance < 10:  
		face.visible = true
	else:
		face.visible = false
