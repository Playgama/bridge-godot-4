var type : get = _type_getter


func _type_getter():
	return _js_leaderboards.type


var _js_leaderboards = null
var _set_score_callback = null
var _js_set_score_then = JavaScriptBridge.create_callback(self._on_js_set_score_then)
var _js_set_score_catch = JavaScriptBridge.create_callback(self._on_js_set_score_catch)
var _get_entries_callback = null
var _js_get_entries_then = JavaScriptBridge.create_callback(self._on_js_get_entries_then)
var _js_get_entries_catch = JavaScriptBridge.create_callback(self._on_js_get_entries_catch)
var _show_native_popup_callback = null
var _js_show_native_popup_then = JavaScriptBridge.create_callback(self._on_js_show_native_popup_then)
var _js_show_native_popup_catch = JavaScriptBridge.create_callback(self._on_js_show_native_popup_catch)

func set_score(id, score, callback = null):
	if _set_score_callback != null:
		return
	
	_set_score_callback = callback
	_js_leaderboards.setScore(id, score).then(_js_set_score_then).catch(_js_set_score_catch)

func get_entries(id, callback = null):
	if _get_entries_callback != null:
		return
	
	_get_entries_callback = callback
	_js_leaderboards.getEntries(id).then(_js_get_entries_then).catch(_js_get_entries_catch)

func show_native_popup(id, callback = null):
	if _show_native_popup_callback != null:
		return
	
	_show_native_popup_callback = callback
	_js_leaderboards.showNativePopup(id).then(_js_show_native_popup_then).catch(_js_show_native_popup_catch)

func _init(js_leaderboards):
	_js_leaderboards = js_leaderboards

func _on_js_set_score_then(args):
	if _set_score_callback != null:
		_set_score_callback.call(true)
		_set_score_callback = null

func _on_js_set_score_catch(args):
	if _set_score_callback != null:
		_set_score_callback.call(false)
		_set_score_callback = null

func _on_js_get_entries_then(args):
	if _get_entries_callback != null:
		var data = args[0]
		var data_type = typeof(data)
		match data_type:
			TYPE_OBJECT:
				var array = []
				for i in range(data.length):
					var js_item = data[i]
					var js_item_keys = JavaScriptBridge.get_interface("Object").keys(js_item)
					var item = {}
					for j in range(js_item_keys.length):
						var key = js_item_keys[j]
						item[key] = js_item[key]
					array.append(item)
				_get_entries_callback.call(true, array)
			_:
				_get_entries_callback.call(false, [])
		_get_entries_callback = null

func _on_js_get_entries_catch(args):
	if _get_entries_callback != null:
		_get_entries_callback.call(false, [])
		_get_entries_callback = null

func _on_js_show_native_popup_then(args):
	if _show_native_popup_callback != null:
		_show_native_popup_callback.call(true)
		_show_native_popup_callback = null

func _on_js_show_native_popup_catch(args):
	if _show_native_popup_callback != null:
		_show_native_popup_callback.call(false)
		_show_native_popup_callback = null
