extends Button


@onready var http_request: HTTPRequest = $HTTPRequest
@onready var time: Label = $"../time"
const URL: String = "https://hizgcpgzmireapqliudy.supabase.co"
const endpoint: String = "/rest/v1/times"
const get_id: String = "https://hizgcpgzmireapqliudy.supabase.co/rest/v1/times"
const KEY: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhpemdjcGd6bWlyZWFwcWxpdWR5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY0MTg5MjAsImV4cCI6MjA1MTk5NDkyMH0.e7UwYnLSBbsOA5kWW8GAQgORwisj4xbykJ0FmpfiCf0"
@onready var player_name: LineEdit = $"../player_name"
@onready var error: Label = $"../error"
@onready var done: Label = $"../done"
@onready var button: Button = $"."

var new_id

var onm = false

func _ready() -> void:
	Input.mouse_mode = 0
	time.text = String(Global.player_time).strip_edges()
	Engine.time_scale = 1
	
	
func _on_pressed() -> void:
	if player_name.text == "" or player_name.text == null:
		error.text = "Write a username!!!"
		await get_tree().create_timer(1.5).timeout
		error.text = ""
	else:
		error.text = ""
		var clean_name = player_name.text.strip_edges()
		var clean_time = String(Global.player_time).strip_edges()
		get_last_id()
		await get_tree().create_timer(1.0).timeout
		print(new_id)
		var new_record = {
		"id": new_id,
		"username": clean_name,
		"times": clean_time
		}
		print("még nem")
		http_post(endpoint, new_record)
		print("most")


func get_last_id():
	var endpoint = "/rest/v1/times?select=id&order=id.desc&limit=1"
	var headers = [
		"apikey: " + KEY,
		 "Authorization: Bearer " + KEY
	]
	http_request.connect("request_completed", Callable(self, "_on_last_id_fetched"))
	http_request.request(URL + endpoint, headers)

func _on_last_id_fetched(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	if response_code == 200:
		var json = JSON.new()
		if json.parse(body.get_string_from_utf8()) == OK:
			var data = json.data
			var last_id = 0
			if data.size() > 0:
				last_id = data[0]["id"] 
			else:
				last_id = 0 
			new_id = last_id + 1
			print(new_id)
		else:
			print("JSON parse error: ", json.error_string())
	else:
		print("Error fetching last ID: ", body.get_string_from_utf8())



func http_post(endpoint: String, data: Dictionary):
	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	var headers = [
		"apikey: " + KEY,
		"Authorization: Bearer " + KEY,
		"Content-Type: application/json" 
	]
	var json_data = JSON.stringify(data)
	var err = http_request.request(URL + endpoint, headers, HTTPClient.METHOD_POST, json_data)
	if err != OK:
		print("HTTP request error: ", err)

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("Response code: ", response_code)
	if response_code == 201:
		print("Record created successfully!")
		error.text = ""
		done.text = "Successfully uploaded!"
	else:
		done.text = ""
		error.text = "ERROR. Please try again!"
		print("Error: ", body.get_string_from_utf8())


func _physics_process(_delta: float) -> void:
	if onm:
		var tween = get_tree().create_tween()
		tween.tween_property(button, "position", Vector2(button.position.x + randf_range(-2, 2),button.position.y + randf_range(-2, 2)), 0.1).set_trans(Tween.TRANS_LINEAR)
	else:
		pass

func _on_mouse_entered() -> void:
	onm = true
	button.modulate = Color(1, 0.2, 0.2)
	


func _on_mouse_exited() -> void:
	onm = false
	button.modulate = Color(1, 1, 1)



func _on_player_name_mouse_entered() -> void:
	player_name.modulate = Color(1, 0.4, 0.4)


func _on_player_name_mouse_exited() -> void:
	player_name.modulate = Color(1, 1, 1)
