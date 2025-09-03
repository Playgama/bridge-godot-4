var is_authorization_supported : get = _is_authorization_supported_getter
var is_authorized : get = _is_authorized_getter
var id : get = _id_getter
var name : get = _name_getter
var photos : get = _photos_getter
var extra : get = _extra_getter


func _is_authorization_supported_getter():
	return false
	
func _is_authorized_getter():
	return false
	
func _id_getter():
	return null

func _name_getter():
	return null

func _photos_getter():
	return []

func _extra_getter():
	return {}


func authorize(options = null, callback = null):
	if callback != null:
		callback.call(false)
