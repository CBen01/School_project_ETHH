extends HSlider

@export var bus_name: String
@onready var master: HSlider = $"."

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	
	value = linear_to_db(
		AudioServer.get_bus_volume_db(bus_index)
	)/10

func _on_value_changed(value: float) -> void:
	Global.volume_change(value,bus_name)
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value/10)
	)
