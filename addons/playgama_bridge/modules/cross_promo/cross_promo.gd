var is_visible : get = _is_visible_getter


var _js_cross_promo = null

var _get_games_list_callback = null
var _js_get_games_list_then = JavaScriptBridge.create_callback(self._on_get_games_list_then)
var _js_get_games_list_catch = JavaScriptBridge.create_callback(self._on_get_games_list_catch)

var _utils = load("res://addons/playgama_bridge/utils.gd").new()

func _is_visible_getter():
	return _js_cross_promo.isVisible

func _init(js_cross_promo):
	_js_cross_promo = js_cross_promo

func get_games(callback):
	if _get_games_list_callback != null:
		return

	_get_games_list_callback = callback
	_js_cross_promo.getGames().then(_js_get_games_list_then).catch(_js_get_games_list_catch)

func show():
	_js_cross_promo.show()

func hide():
	_js_cross_promo.hide()


func _on_get_games_list_then(args):
	var data = args[0]
	var data_type = typeof(data)
	match data_type:
		TYPE_OBJECT:
			var array = []
			for i in range(data.length):
				var item = _utils.convert_to_gd_object(data[i])
				array.append(item)
			_get_games_list_callback.call(true, array)
		_:
			_get_games_list_callback.call(false, [])
	_get_games_list_callback = null

func _on_get_games_list_catch(args):
	if _get_games_list_callback != null:
		_get_games_list_callback.call(false, [])
		_get_games_list_callback = null
