extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		Global.room3 = true


func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		Global.room3 = false
