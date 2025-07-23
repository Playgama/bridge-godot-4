signal audio_state_changed
signal pause_state_changed

var id : get = _id_getter
var payload : get = _payload_getter
var language : get = _language_getter
var tld : get = _tld_getter
var is_audio_enabled : get = _is_audio_enabled_getter
var is_get_all_games_supported : get = _is_get_all_games_supported_getter
var is_get_game_by_id_supported : get = _is_get_game_by_id_supported_getter


var _js_platform = null
var _get_server_time_callback = null
var _js_get_server_time_then = JavaScriptBridge.create_callback(self._on_js_get_server_time_then)
var _js_get_server_time_catch = JavaScriptBridge.create_callback(self._on_js_get_server_time_catch)

var _get_all_games_callback = null
var _js_get_all_games_then = JavaScriptBridge.create_callback(self._on_get_all_games_then)
var _js_get_all_games_catch = JavaScriptBridge.create_callback(self._on_get_all_games_catch)

var _get_game_by_id_callback = null
var _js_get_game_by_id_then = JavaScriptBridge.create_callback(self._on_get_game_by_id_then)
var _js_get_game_by_id_catch = JavaScriptBridge.create_callback(self._on_get_game_by_id_catch)

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

func _is_get_all_games_supported_getter():
	return _js_platform.isGetAllGamesSupported

func _is_get_game_by_id_supported_getter():
	return _js_platform.isGetGameByIdSupported
	
func _init(js_platform):
	_js_platform = js_platform
	_js_platform.on('audio_state_changed', _js_on_audio_state_changed)
	_js_platform.on('pause_state_changed', _js_on_pause_state_changed)

func send_message(message):
	_js_platform.sendMessage(message)

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

func get_all_games(callback):
	if _get_all_games_callback != null:
		return
		
	_get_all_games_callback = callback
	_js_platform.getAllGames().then(_js_get_all_games_then).catch(_js_get_all_games_catch)

func _on_get_all_games_then(args):
	var data = args[0]
	var data_type = typeof(data)
	match data_type:
		TYPE_OBJECT:
			var array = []
			for i in range(data.length):
				var item = _utils.convert_to_gd_object(data[i])
				array.append(item)
			_get_all_games_callback.call(true, array)
		_:
			_get_all_games_callback.call(false, [])
	_get_all_games_callback = null

func _on_get_all_games_catch(args):
	if _get_all_games_callback != null:
		_get_all_games_callback.call(false, [])
		_get_all_games_callback = null

func get_game_by_id(options = null, callback = null):
	if _get_game_by_id_callback != null:
		return
	
	_get_game_by_id_callback = callback
	
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)
	
	_js_platform.getGameById(js_options).then(_js_get_game_by_id_then).catch(_js_get_game_by_id_catch)
	
func _on_get_game_by_id_then(args):
	if _get_game_by_id_callback != null:
		var data = args[0]
		var data_type = typeof(data)
		match data_type:
			TYPE_OBJECT:
				var item = _utils.convert_to_gd_object(data)
				_get_game_by_id_callback.call(true, item)
			_:
				_get_game_by_id_callback.call(false, null)
		_get_game_by_id_callback = null

func _on_get_game_by_id_catch(args):
	if _get_game_by_id_callback != null:
		_get_game_by_id_callback.call(false, null)
		_get_game_by_id_callback = null
