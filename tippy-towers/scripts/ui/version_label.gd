extends RichTextLabel

func _ready():
	text = str("web:", OS.has_feature("web"),",web_android:", OS.has_feature("web_android"),",is_mobile_web:", is_mobile_web())

func is_mobile_web():
	# This doesn't currently work
	if OS.has_feature("JavaScript"):
		# Use JavaScript to detect mobile browsers
		return JavaScriptBridge.eval("""
			/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
		""")
	return false
