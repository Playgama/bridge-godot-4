const _FILE_EXTENSION = ".save"


func get(key, callback = null):
	if callback == null:
		return

	var key_type = typeof(key)
	var success = false
	var data = null

	match key_type:
		TYPE_STRING:
			data = _get(key)
			success = true

		TYPE_ARRAY:
			data = []
			for k in key:
				data.append(_get(k))
			success = true

		_:
			success = false

	callback.call(success, data)

func set(key, value, callback = null):
	var key_type = typeof(key)
	var success = false

	match key_type:
		TYPE_STRING:
			_set(key, value)
			success = true
		TYPE_ARRAY:
			for i in key.size():
				_set(key[i], value[i])
			success = true
		_:
			success = false

	if callback != null:
		callback.call(success)

func delete(key, callback = null):
	var key_type = typeof(key)
	var success = false

	match key_type:
		TYPE_STRING:
			_delete(key)
			success = true
		TYPE_ARRAY:
			for k in key:
				_delete(k)
			success = true
		_:
			success = false

	if callback != null:
		callback.call(success)


func _get_file_path(key):
	return "user://" + key + _FILE_EXTENSION

func _get(key):
	var path = _get_file_path(key)

	if not FileAccess.file_exists(path):
		return null

	var file = FileAccess.open(path, FileAccess.READ)
	var data = file.get_as_text()
	file = null

	if data.is_empty():
		return null
	else:
		return data

func _set(key, value):
	var path = _get_file_path(key)
	var file = FileAccess.open(path, FileAccess.WRITE)

	if (typeof(value) != TYPE_STRING):
		value = str(value)

	file.store_string(value)
	file = null

func _delete(key):
	var path = _get_file_path(key)

	if not FileAccess.file_exists(path):
		return

	DirAccess.remove_absolute(path)
