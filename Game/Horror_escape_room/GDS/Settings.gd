extends Control





@onready var value_X: Label = $settings/Xsens/value
@onready var value_Y: Label = $settings/Ysens/value
@onready var xsens: HSlider = $settings/Xsens
@onready var ysens: HSlider = $settings/Ysens

@onready var forward_key: Button = $Input/forward/MarginContainer/forward_key
@onready var backwards_key: Button = $Input/backwards/MarginContainer/backward_key
@onready var left_key: Button = $Input/left/MarginContainer/left_key
@onready var right_key: Button = $Input/right/MarginContainer/right_key
@onready var interact_key: Button = $Input/interact/MarginContainer/interact_key
@onready var flashlight_key: Button = $Input/Flashlight/MarginContainer/Flashlight_key
@onready var sprint_key: Button = $Input/Sprint/MarginContainer/sprint_key
@onready var crouch_key: Button = $Input/Crouch/MarginContainer/crouch_key

@onready var fps: Label = $"../main_UI/Label"


var key_changed
var action

@onready var fps_button: Button = $settings/FPS


func _ready() -> void:
	if Global.FPS:
		fps_button.text = "Show FPS: ON"
		fps.visible = true
	else:
		fps_button.text = "Show FPS: OFF"
		fps.visible = false
	xsens.value = Global.X_back_up * 100
	ysens.value = Global.Y_back_up * 100 * -1
	key_changed
	action

func _on_h_slider_value_changed(value):
	value_X.text = str(value)
	Global.X_back_up = (value / 100)


func _on_ysens_value_changed(value):
	value_Y.text = str(value)
	Global.Y_back_up = (value / 100) * -1


func _on_back_pressed() -> void:
	$"../menu_pressed".play()
	Global.Menu -= 1


func _on_back_mouse_entered() -> void:
	$"../menu_hover".play()


func _on_keybinds_pressed() -> void:
	$"../menu_pressed".play()
	Global.Menu = 3
	forward_key.text = Global.fk
	backwards_key.text = Global.bk
	left_key.text = Global.lk
	right_key.text = Global.rk
	interact_key.text = Global.ikt
	flashlight_key.text = Global.flsh
	sprint_key.text = Global.sprint
	crouch_key.text = Global.crch


func _on_keybinds_mouse_entered() -> void:
	$"../menu_hover".play()


func _on_button_pressed() -> void:
	$"../menu_pressed".play()
	xsens.value = 10
	ysens.value = 10


func _on_button_mouse_entered() -> void:
	$"../menu_hover".play()
	
func _on_forward_key_pressed() -> void:
	forward_key.text = "..."
	key_changed = forward_key
	action = "up"
	set_process_input(true)
	
func _on_backward_key_pressed() -> void:
	backwards_key.text = "..."
	key_changed = backwards_key
	action = "down"
	set_process_input(true)
	
func _on_left_key_pressed() -> void:
	left_key.text = "..."
	key_changed = left_key
	action = "left"
	set_process_input(true)
	
func _on_right_key_pressed() -> void:
	right_key.text = "..."
	key_changed = right_key
	action = "right"
	set_process_input(true)
	

func _on_interact_key_pressed() -> void:
	interact_key.text = "..."
	key_changed = interact_key
	action = "interact"
	set_process_input(true)
	
func _on_flashlight_key_pressed() -> void:
	flashlight_key.text = "..."
	key_changed = flashlight_key
	action = "flash"
	set_process_input(true)
	
func _on_sprint_key_pressed() -> void:
	sprint_key.text = "..."
	key_changed = sprint_key
	action = "sprint"
	set_process_input(true)
	
func _on_crouch_key_pressed() -> void:
	crouch_key.text = "..."
	key_changed = crouch_key
	action = "crouch"
	set_process_input(true)
	
	
func _input(event: InputEvent) -> void:
	# Check if we are listening for a key press and if the event is a valid key press
	if event is InputEventKey and event.pressed and action != null and key_changed != null:
		# Stop listening for input
		set_process_input(false)
		
		# Update the keybind for the "up" action
		InputMap.action_erase_events(action)  # Clear existing keybinds for "up"
		InputMap.action_add_event(action, event)  # Add the new key
		
		# Update the button text to show the new key
		var key_name = event.as_text()
		key_changed.text = key_name
		if action == "up":
			Global.fk = key_name
		elif action == "down":
			Global.bk = key_name
		elif action == "left":
			Global.lk = key_name
		elif action == "right":
			Global.rk = key_name
		elif action == "interact":
			Global.ikt = key_name
			Global.Interact_button = key_name
		elif action == "flash":
			Global.flsh = key_name
		elif action == "sprint":
			Global.sprint = key_name
		elif action == "crouch":
			Global.crch = key_name


func _on_fps_pressed() -> void:
	if fps_button.text == "Show FPS: OFF":
		Global.FPS = true
		fps_button.text = "Show FPS: ON"
		fps.visible = true
	else:
		Global.FPS = false
		fps_button.text = "Show FPS: OFF"
		fps.visible = false
