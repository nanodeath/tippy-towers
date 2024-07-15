class_name PackagesLost extends Container

@onready var package_lost_zone = %PackageLostZone
@onready var packages_lost = $PackagesLost

func _ready():
	package_lost_zone.package_lost.connect(self._package_lost)

func _package_lost(total: int):
	packages_lost.text = str(total)
