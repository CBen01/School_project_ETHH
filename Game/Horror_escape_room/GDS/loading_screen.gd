extends Control


var progress = []
var scenename
var scene_load_status = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scenename = Global.next_scene
	ResourceLoader.load_threaded_request(scenename)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(scenename,progress)
	$progress.text = str(floor(progress[0]*100)) + "%"
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var NewScene = ResourceLoader.load_threaded_get(scenename)
		get_tree().change_scene_to_packed(NewScene)
