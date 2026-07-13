var type : get = _type_getter

func _type_getter():
	match OS.get_name():
		"Android":
			return Bridge.DeviceType.MOBILE
		_:
			return Bridge.DeviceType.DESKTOP
