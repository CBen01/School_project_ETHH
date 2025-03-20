extends Node3D

@onready var animationtree : AnimationTree = $AnimationTree
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animationtree["parameters/conditions/active"] == true:
		Global.lever_one = true
	elif animationtree["parameters/conditions/active"] == false:
		Global.lever_one = false
