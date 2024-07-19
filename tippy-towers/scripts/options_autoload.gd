extends Node

func _ready():
	load_preferences()

func save_preferences():
	var config := ConfigFile.new()
	config.set_value("audio_level", "overall", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	config.set_value("audio_level", "music", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	config.set_value("audio_level", "sfx", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	config.save("user://preferences.cfg")

func load_preferences():
	var config = ConfigFile.new()
	var err = config.load("user://preferences.cfg")
	if err != OK:
		return
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), config.get_value("audio_level", "overall", 0))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), config.get_value("audio_level", "music", -20))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), config.get_value("audio_level", "sfx", 0))
