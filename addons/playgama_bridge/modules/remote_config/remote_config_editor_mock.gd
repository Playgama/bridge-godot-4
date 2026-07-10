var is_supported : get = _is_supported_getter


func _is_supported_getter():
	return false


func set_context(parameters):
	pass


func get(callback = null):
	if callback == null:
		return null

	callback.call(false, null)
	return null
