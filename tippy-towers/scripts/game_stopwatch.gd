class_name GameStopwatch extends Node

var time_running := 0.0

func _process(delta):
	time_running += delta
