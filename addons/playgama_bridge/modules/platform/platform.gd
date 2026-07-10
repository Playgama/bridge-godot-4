signal audio_state_changed
signal pause_state_changed

var id : get = _id_getter
var payload : get = _payload_getter
var language : get = _language_getter
var tld : get = _tld_getter
var is_audio_enabled : get = _is_audio_enabled_getter
var is_external_calls_supported : get = _is_external_calls_supported_getter
var is_external_links_allowed : get = _is_external_links_allowed_getter


var _js_platform = null
var _get_server_time_callback = null
var _js_get_server_time_then = JavaScriptBridge.create_callback(self._on_js_get_server_time_then)
var _js_get_server_time_catch = JavaScriptBridge.create_callback(self._on_js_get_server_time_catch)

var _js_on_audio_state_changed = JavaScriptBridge.create_callback(self._on_audio_state_changed)
var _js_on_pause_state_changed = JavaScriptBridge.create_callback(self._on_pause_state_changed)

var _utils = load("res://addons/playgama_bridge/utils.gd").new()

func _id_getter():
	return _js_platform.id

func _payload_getter():
	return _js_platform.payload

func _language_getter():
	return _js_platform.language

func _tld_getter():
	return _js_platform.tld

func _is_audio_enabled_getter():
	return _js_platform.isAudioEnabled

func _is_external_calls_supported_getter():
	return _js_platform.isExternalCallsSupported

func _is_external_links_allowed_getter():
	return _js_platform.isExternalLinksAllowed

func _init(js_platform):
	_js_platform = js_platform
	_js_platform.on('audio_state_changed', _js_on_audio_state_changed)
	_js_platform.on('pause_state_changed', _js_on_pause_state_changed)

func send_message(message, options = null):
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)
	_js_platform.sendMessage(message, js_options)

func send_custom_message(id, options = null):
	if options:
		var js_options = _utils.convert_to_js(options)
		_js_platform.sendCustomMessage(id, js_options)
	else:
		_js_platform.sendCustomMessage(id)

func get_server_time(callback):
	if _get_server_time_callback != null:
		return
	
	_get_server_time_callback = callback
	_js_platform.getServerTime().then(_js_get_server_time_then).catch(_js_get_server_time_catch)


func _on_audio_state_changed(args):
	emit_signal("audio_state_changed", args[0])

func _on_pause_state_changed(args):
	emit_signal("pause_state_changed", args[0])

func _on_js_get_server_time_then(args):
	if _get_server_time_callback != null:
		var data = args[0]
		var data_type = typeof(data)
		match data_type:
			TYPE_INT:
				_get_server_time_callback.call(data)
			_:
				_get_server_time_callback.call(0)
		_get_server_time_callback = null

func _on_js_get_server_time_catch(args):
	if _get_server_time_callback != null:
		_get_server_time_callback.call(0)
		_get_server_time_callback = null
