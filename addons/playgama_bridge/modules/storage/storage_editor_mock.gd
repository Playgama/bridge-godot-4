var default_type : get = _default_type_getter

const _FILE_EXTENSION = ".save"

func _default_type_getter():
	return Bridge.StorageType.LOCAL_STORAGE


func is_supported(storage_type):
	match storage_type:
		Bridge.StorageType.LOCAL_STORAGE:
			return true
		_:
			return false

func is_available(storage_type):
	match storage_type:
		Bridge.StorageType.LOCAL_STORAGE:
			return true
		_:
			return false

func get(key, callback = null, storage_type = null):
	if callback == null:
		return null

	if storage_type != null and not is_supported(storage_type):
		callback.call(false, null)
		return null

	var key_type = typeof(key)
	var success = false
	var data = null

	match key_type:
		TYPE_STRING:
			data = _read_file(key)
			success = true

		TYPE_ARRAY:
			data = []
			for k in key:
				data.append(_read_file(k))
			success = true

		_:
			success = false

	callback.call(success, data)
	return null

func set(key, value, callback = null, storage_type = null):
	if storage_type != null and not is_supported(storage_type):
		callback.call(false)
		return
	
	var key_type = typeof(key)
	var success = false
	
	match key_type:
		TYPE_STRING:
			_write_file(key, value)
			success = true
		TYPE_ARRAY:
			for i in key.size():
				_write_file(key[i], value[i])
			success = true
		_:
			success = false
	
	if callback != null:
		callback.call(success)

func delete(key, callback = null, storage_type = null):
	if storage_type != null and not is_supported(storage_type):
		callback.call(false)
		return
	
	var key_type = typeof(key)
	var success = false
	
	match key_type:
		TYPE_STRING:
			_delete_file(key)
			success = true
		TYPE_ARRAY:
			for k in key:
				_delete_file(k)
			success = true
		_:
			success = false
	
	if callback != null:
		callback.call(success)


func _get_file_path(key):
	return "user://" + key + _FILE_EXTENSION

func _read_file(key):
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

func _write_file(key, value):
	var path = _get_file_path(key)
	var file = FileAccess.open(path, FileAccess.WRITE)

	if (typeof(value) != TYPE_STRING):
		value = str(value)

	file.store_string(value)
	file = null

func _delete_file(key):
	var path = _get_file_path(key)

	if not FileAccess.file_exists(path):
		return

	DirAccess.remove_absolute(path)
