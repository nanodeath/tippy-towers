class_name JunkFreezer extends Node

@onready var highest_point_detector = %HighestPointDetector

var junk := [] as Array[RigidBody2D]
const max_unfrozen_junk := 8

func _ready():
	highest_point_detector.new_highest_junk.connect(self.handle_new_junk)

func handle_new_junk(box: RigidBody2D):
	junk.push_back(box)
	while junk.size() > max_unfrozen_junk:
		var to_freeze := junk.pop_front() as RigidBody2D
		to_freeze.freeze = true
