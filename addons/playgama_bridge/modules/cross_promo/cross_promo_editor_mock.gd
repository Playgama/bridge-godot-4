var is_visible : get = _is_visible_getter

func _is_visible_getter():
	return false

func get_games(callback):
	if callback != null:
		callback.call(true, [])

func show():
	pass

func hide():
	pass
