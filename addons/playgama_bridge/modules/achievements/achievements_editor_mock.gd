func unlock(id, callback = null):
	if callback != null:
		callback.call(false)

func get_achievements(callback = null):
	if callback != null:
		callback.call(false, [])
