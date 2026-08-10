const _FILE_EXTENSION = ".save"

var _utils = load("res://addons/playgama_bridge/utils.gd").new()


func get(key, callback = null, try_parse_json = false):
	if callback == null:
		return null

	var key_type = typeof(key)
	var success = false
	var data = null

	match key_type:
		TYPE_STRING:
			data = _read_value(key, try_parse_json)
			success = true

		TYPE_ARRAY:
			data = []
			for k in key:
				data.append(_read_value(k, try_parse_json))
			success = true

		_:
			success = false

	callback.call(success, data)
	return null

func set(key, value = null, callback = null):
	var key_type = typeof(key)
	var success = false

	match key_type:
		TYPE_STRING:
			_write_value(key, value)
			success = true
		TYPE_ARRAY:
			for i in key.size():
				_write_value(key[i], value[i])
			success = true
		TYPE_DICTIONARY:
			# set(data, callback) — the second argument is the callback in this form
			if callback == null:
				callback = value

			for k in key:
				_write_value(k, key[k])
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
			_delete_value(key)
			success = true
		TYPE_ARRAY:
			for k in key:
				_delete_value(k)
			success = true
		_:
			success = false

	if callback != null:
		callback.call(success)


func _get_file_path(key):
	return "user://" + key + _FILE_EXTENSION

func _read_value(key, try_parse_json):
	var path = _get_file_path(key)

	if not FileAccess.file_exists(path):
		return null

	var file = FileAccess.open(path, FileAccess.READ)
	var data = file.get_as_text()
	file = null

	if data.is_empty():
		return null
	elif try_parse_json:
		return _utils.deserialize_value(data)
	else:
		return data

func _write_value(key, value):
	var path = _get_file_path(key)
	var file = FileAccess.open(path, FileAccess.WRITE)

	value = _utils.serialize_value(value)

	# Matches how the JS SDK stores primitives, so the mock and the web keep the same format
	if (typeof(value) != TYPE_STRING):
		value = JSON.stringify(value)

	file.store_string(value)
	file = null

func _delete_value(key):
	var path = _get_file_path(key)

	if not FileAccess.file_exists(path):
		return

	DirAccess.remove_absolute(path)
