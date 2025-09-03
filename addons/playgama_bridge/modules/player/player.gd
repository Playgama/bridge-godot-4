var is_authorization_supported : get = _is_authorization_supported_getter
var is_authorized : get = _is_authorized_getter
var id : get = _id_getter
var name : get = _name_getter
var photos : get = _photos_getter
var extra : get = _extra_getter


func _is_authorization_supported_getter():
	return _js_player.isAuthorizationSupported

func _is_authorized_getter():
	return _js_player.isAuthorized

func _id_getter():
	return _js_player.id

func _name_getter():
	return _js_player.name

func _extra_getter():
	return _utils.convert_to_gd_object(_js_player.extra)

func _photos_getter():
	var array = []
	for i in range(_js_player.photos.length):
		array.append(_js_player.photos[i])
	return array

var _js_player = null
var _js_authorize_then = JavaScriptBridge.create_callback(self._on_js_authorize_then)
var _js_authorize_catch = JavaScriptBridge.create_callback(self._on_js_authorize_catch)
var _authorize_callback = null
var _utils = load("res://addons/playgama_bridge/utils.gd").new()


func authorize(options = null, callback = null):
	if _authorize_callback != null:
		return
	
	_authorize_callback = callback
	
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)
	
	_js_player.authorize(js_options).then(_js_authorize_then).catch(_js_authorize_catch)


func _init(js_player):
	_js_player = js_player

func _on_js_authorize_then(args):
	if _authorize_callback != null:
		_authorize_callback.call(true)
		_authorize_callback = null

func _on_js_authorize_catch(args):
	if _authorize_callback != null:
		_authorize_callback.call(false)
		_authorize_callback = null
