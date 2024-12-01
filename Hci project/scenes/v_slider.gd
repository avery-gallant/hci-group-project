extends VSlider

@export
var bus_name: String

var bus_index: int

var prevValue

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	
	value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)
	
	prevValue = 1

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)

func _on_volumeicon_toggled(toggled_on: bool) -> void:
	if(toggled_on): 
		prevValue = value
		value = 0
	else: value = prevValue
