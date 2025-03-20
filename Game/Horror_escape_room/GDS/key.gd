extends Area3D

@onready var message: Label = $"../../../Player_UI/main_UI/Message"
@onready var pick_up: AudioStreamPlayer2D = $"../../pick_up"
var count = 0


func _on_body_entered(body: Node3D) -> void:
	if body.name == Global.player_name and count == 0:
		count = 1
		Global.has_key = true
		pick_up.play()
		message.text = "Found the key!"
		await  get_tree().create_timer(1.0).timeout
		message.text = ""
		self.queue_free()
