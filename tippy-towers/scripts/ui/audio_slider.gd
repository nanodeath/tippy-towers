class_name AudioSlider extends Slider

@export var audio_bus: StringName

var bus_idx: int

func _ready():
	bus_idx = AudioServer.get_bus_index(audio_bus)
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_idx))
	value_changed.connect(self._on_value_changed)

func _on_value_changed(value: float):
	var db := linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_idx, db)
	print("value: ", value, ", db: ", db)
