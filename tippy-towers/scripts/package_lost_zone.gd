class_name PackageLostZone extends Area2D

var packages_lost: int = 0

signal package_lost(total_count: int)

func _ready():
	body_entered.connect(self._junk_entered)

func _junk_entered(body: Node):
	packages_lost += 1
	emit_signal("package_lost", packages_lost)
	body.queue_free()
