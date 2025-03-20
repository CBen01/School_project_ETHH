extends Control


var loading = preload("res://jelenetek/loading_screen.tscn")
var onm = false
@onready var button: Button = $main_menu

@onready var bg: TextureRect = $bg
@onready var name_label: Label = $name
var messages = ["You're useless", "Why are you still here?", "It's watching you.", "WHO ARE YOU?"]

func _on_timer_timeout() -> void:	
	var chance = randi() % 100
	if chance > 10 and chance < 30:  
		name_label.text = messages[randi() % messages.size()]
		await get_tree().create_timer(.75).timeout 
		name_label.text = "Write your player name:"
	else:
		pass


func _on_main_menu_pressed() -> void:
	Global.next_scene = "res://jelenetek/menu.tscn"
	get_tree().change_scene_to_packed(loading)


func _physics_process(_delta: float) -> void:
	if onm:
		var tween = get_tree().create_tween()
		tween.tween_property(button, "position", Vector2(button.position.x + randf_range(-2, 2),button.position.y + randf_range(-2, 2)), 0.1).set_trans(Tween.TRANS_LINEAR)
	else:
		pass

func _on_main_menu_mouse_entered() -> void:
	onm = true
	button.modulate = Color(1, 0.2, 0.2)


func _on_main_menu_mouse_exited() -> void:
	onm = false
	button.modulate = Color(1, 1, 1)
