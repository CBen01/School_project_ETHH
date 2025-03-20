extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var face_node = $Face
@onready var monster: CharacterBody3D = $"."


var SPEED = 1.5

func _physics_process(delta: float) -> void:
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	if current_location.round() == next_location.round():
		Global.E1 = 1
		await get_tree().create_timer(0.5).timeout
		Global.E1 = 0
	else:
		Global.E1 = 0
	
	velocity = new_velocity
	move_and_slide()

func update_target_location(target_location):
	nav_agent.set_target_position(target_location)
	var direction_to_player = (target_location - global_transform.origin)
	direction_to_player.y = 0  # Ignore the vertical component

	if direction_to_player.length() > 0:  # Avoid division by zero
		var target_rotation = direction_to_player.normalized()
		look_at(global_transform.origin + target_rotation, Vector3.UP)
		
func update_animation(idle,lock_on):
	$AnimationTree["parameters/conditions/idle"] = idle
	$AnimationTree["parameters/conditions/lock_on"] = lock_on


func _on_face_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		Global.death = true
		Global.can_move = false
		monster.queue_free()
