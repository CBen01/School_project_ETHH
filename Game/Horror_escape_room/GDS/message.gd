extends Label

@onready var message_text: Label = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
		
	if Global.ch:
		message_text.text = "Press (" + Global.flsh + ") to turn it on/off"
		
	if Input.is_action_just_pressed("flash") and message_text.text == "Press (" + Global.flsh + ") to turn it on/off":
		message_text.text = "Press (" + Global.flsh_chng + ") to change flashlight position"
		Global.ch = false
		
	if Input.is_action_just_pressed("change") and message_text.text == "Press (" + Global.flsh_chng + ") to change flashlight position":
		message_text.text = ""
