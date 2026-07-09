var is_supported : get = _is_supported_getter


func _is_supported_getter():
	return _js_remote_config.isSupported

var _js_remote_config = null
var _is_getting = false
var _get_callback = null
var _js_get_then = JavaScriptBridge.create_callback(self._on_js_get_then)
var _js_get_catch = JavaScriptBridge.create_callback(self._on_js_get_catch)
var _utils = load("res://addons/playgama_bridge/utils.gd").new()


func get(options = null, callback = null):
	if _is_getting:
		return null

	if callback == null:
		return null

	_is_getting = true
	_get_callback = callback

	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)

	_js_remote_config.get(js_options).then(_js_get_then).catch(_js_get_catch)
	return null


func _init(js_remote_config):
	_js_remote_config = js_remote_config

func _on_js_get_then(args):
	_is_getting = false
	if _get_callback == null:
		return
	
	var data = args[0]
	var data_type = typeof(data)
	match data_type:
		TYPE_OBJECT:
			var values = {}
			var keys = JavaScriptBridge.get_interface("Object").keys(data)
			for i in range(keys.length):
				values[keys[i]] = data[keys[i]]
			_get_callback.call(true, values)
		_:
			_get_callback.call(true, data)

func _on_js_get_catch(args):
	_is_getting = false
	if _get_callback != null:
		_get_callback.call(false, null)
