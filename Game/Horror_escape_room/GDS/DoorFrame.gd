extends Node3D

@onready var animationtree : AnimationTree = $"../AnimationTree"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#megnézi hogy az összes kar használva lett-e vagy sem és nyitva legyen-e az ajtó vagy sem
func _process(_delta):
	if Global.lever_one and Global.lever_two and Global.lever_three:
		animationtree["parameters/conditions/idle"] = false
		animationtree["parameters/conditions/open"] = true
		animationtree["parameters/conditions/close"] = false
	if animationtree["parameters/conditions/open"] == true and (!Global.lever_one or !Global.lever_two or !Global.lever_three):
		animationtree["parameters/conditions/idle"] = false
		animationtree["parameters/conditions/open"] = false
		animationtree["parameters/conditions/close"] = true
		await get_tree().create_timer(.1).timeout
		animationtree["parameters/conditions/idle"] = true
		animationtree["parameters/conditions/open"] = false
		animationtree["parameters/conditions/close"] = false
