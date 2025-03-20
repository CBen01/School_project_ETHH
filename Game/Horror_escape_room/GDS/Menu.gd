extends Control


@onready var music: AudioStreamPlayer2D = $"../menu_music"
@onready var music2: AudioStreamPlayer2D = $"../music2"

func _ready() -> void:
	music.stream = load("res://sounds/horror/horror-background-atmosphere-6-199279.mp3")
	music2.stream = load("res://sounds/horror/horror-game-menu-25388.mp3")
	music.play()
	music2.play()
	await get_tree().create_timer(0.2).timeout
	music2.stream_paused = true


func _process(delta: float) -> void:
	if Global.Menu != 0:
		if !music2.playing:
			music.stream_paused = true
			music2.stream_paused = false
	elif Global.Menu == 0:
		if !music.playing:
			music.stream_paused = false
			music2.stream_paused = true

func _on_cont_pressed():
	$"../menu_pressed".play()
	Global.Menu = 0


func _on_sett_pressed():
	$"../menu_pressed".play()
	Global.Menu = 2


func _on_cont_mouse_entered() -> void:
	$"../menu_hover".play()


func _on_sett_mouse_entered() -> void:
	$"../menu_hover".play()


func _on_leave_mouse_entered() -> void:
	$"../menu_hover".play()
