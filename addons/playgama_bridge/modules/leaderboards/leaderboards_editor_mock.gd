var type : get = _type_getter


func _type_getter():
	return Bridge.LeaderboardType.NOT_AVAILABLE


func set_score(id, score, callback = null):
	if callback != null:
		callback.call(false)

func get_entries(id, callback = null):
	if callback != null:
		callback.call(false, [])

func show_native_popup(id, callback = null):
	if callback != null:
		callback.call(false)
