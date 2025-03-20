extends Node

var can_move: bool = true
var death: bool = false
var FPS: float = false

var next_scene: String

var time = 0
var player_time: String
var player_name: String

func volume_change(num, bus_name):
	if bus_name == "Master":
		Master = num
	elif bus_name == "Music":
		Music = num
	elif bus_name == "Sfx":
		Sfx = num

var Master: float = 10.0
var Music: float = 10.0
var Sfx: float = 10.0

var EG = 10.0
var Menu = 0

var lever_3: bool = false
var lever_3_count = 0
var E1 = 0

var Xsens = .1
var Ysens = -.1

var X_back_up = .1
var Y_back_up = -.1

var lever_one: bool = false
var lever_two: bool = false
var lever_three: bool = false

var inventory = 0

var battery_used: bool = false

var room3: bool = false
var lever_r3: bool = false

var Interact_button = "e"
var flsh_chng = "v"
var ch = false

var room1_cw: bool = true

var has_light: bool = false
var has_key: bool = false

var fk = "W"
var bk = "S"
var lk = "A"
var rk = "D"
var ikt = "E"
var flsh = "F"
var sprint = "SHIFT"
var crch = "CTRL"
