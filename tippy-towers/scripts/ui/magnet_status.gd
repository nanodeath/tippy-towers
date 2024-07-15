class_name MagnetStatus extends Control

@onready var status: RichTextLabel = $Status
@onready var crane = %Crane


func _ready():
	crane.magnet_changed.connect(self._magnet_changed)
	_magnet_changed(crane.magnet_activated)

func _magnet_changed(magnet_on: bool):
	status.text = "On" if magnet_on else "Off"
