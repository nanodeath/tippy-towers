class_name Game extends Node2D

var is_game_over: bool

signal game_over

func _ready():
	# TODO remove
	%PackageLostZone.package_lost.connect(func(count): trigger_game_over())

func trigger_game_over():
	if not is_game_over:
		is_game_over = true
		emit_signal("game_over")
