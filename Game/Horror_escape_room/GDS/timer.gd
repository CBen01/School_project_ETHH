extends Label

var time = Global.time
@onready var timer: Label = $"."


func _physics_process(delta: float):
	time = float(time) + delta
	update_timer()
	
func update_timer():
	# Calculate minutes, seconds, and milliseconds
	var minutes = int(time) / 60
	var seconds = int(time) % 60
	var milliseconds = int((time - int(time)) * 100)
	
	# Format the time as "MM:SS:MS"
	var format = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2) + ":" + str(milliseconds).pad_zeros(2)
	
	Global.time = time
	Global.player_time = String(format)
	timer.text = String(format)
	


func _on_button_pressed() -> void:
	var db = load("res://jelenetek/upload.tscn")
	get_tree().change_scene_to_packed(db)
