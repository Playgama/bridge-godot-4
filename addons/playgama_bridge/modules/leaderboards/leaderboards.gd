var type : get = _type_getter


func _type_getter():
	return _js_leaderboards.type


var _js_leaderboards = null
var _utils = load("res://addons/playgama_bridge/utils.gd").new()
var _set_score_callback = null
var _js_set_score_then = JavaScriptBridge.create_callback(self._on_js_set_score_then)
var _js_set_score_catch = JavaScriptBridge.create_callback(self._on_js_set_score_catch)
var _get_entries_callback = null
var _js_get_entries_then = JavaScriptBridge.create_callback(self._on_js_get_entries_then)
var _js_get_entries_catch = JavaScriptBridge.create_callback(self._on_js_get_entries_catch)
var _get_info_callback = null
var _js_get_info_then = JavaScriptBridge.create_callback(self._on_js_get_info_then)
var _js_get_info_catch = JavaScriptBridge.create_callback(self._on_js_get_info_catch)
var _show_native_popup_callback = null
var _js_show_native_popup_then = JavaScriptBridge.create_callback(self._on_js_show_native_popup_then)
var _js_show_native_popup_catch = JavaScriptBridge.create_callback(self._on_js_show_native_popup_catch)

# For a leaderboard with the sum score mode (see get_info) the score is added to the player's total:
# pass what the player earned, e.g. 120.
func set_score(id, score, callback = null):
	if _set_score_callback != null:
		return
	
	_set_score_callback = callback
	_js_leaderboards.setScore(id, score).then(_js_set_score_then).catch(_js_set_score_catch)

# period is one of Bridge.LeaderboardPeriod, the standings to read; platform leaderboards have only
# the permanent one.
func get_entries(id, callback = null, period = Bridge.LeaderboardPeriod.PERMANENT):
	if _get_entries_callback != null:
		return
	
	_get_entries_callback = callback
	_js_leaderboards.getEntries(id, _utils.convert_to_js({ "period": period })).then(_js_get_entries_then).catch(_js_get_entries_catch)

# The callback receives (success, info): { id, score_mode, periods, time_left }. score_mode is one of
# Bridge.LeaderboardScoreMode, periods lists the Bridge.LeaderboardPeriod values get_entries can read,
# time_left is { daily, weekly, monthly }: whole seconds until each period resets, null when the
# leaderboard has no such period.
func get_info(id, callback = null):
	if _get_info_callback != null:
		return

	_get_info_callback = callback
	_js_leaderboards.getInfo(id).then(_js_get_info_then).catch(_js_get_info_catch)

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

func _on_js_get_info_then(args):
	if _get_info_callback != null:
		var data = args[0]
		match typeof(data):
			TYPE_OBJECT:
				var periods = []
				var js_periods = data.periods
				if typeof(js_periods) == TYPE_OBJECT:
					for i in range(js_periods.length):
						periods.append(js_periods[i])
				var js_time_left = data.timeLeft
				var time_left = {}
				for period in [Bridge.LeaderboardPeriod.DAILY, Bridge.LeaderboardPeriod.WEEKLY, Bridge.LeaderboardPeriod.MONTHLY]:
					time_left[period] = _get_seconds_left(js_time_left, period)
				_get_info_callback.call(true, {
					"id": data.id,
					"score_mode": data.scoreMode,
					"periods": periods,
					"time_left": time_left
				})
			_:
				_get_info_callback.call(false, null)
		_get_info_callback = null

func _on_js_get_info_catch(args):
	if _get_info_callback != null:
		_get_info_callback.call(false, null)
		_get_info_callback = null

func _on_js_show_native_popup_then(args):
	if _show_native_popup_callback != null:
		_show_native_popup_callback.call(true)
		_show_native_popup_callback = null

func _on_js_show_native_popup_catch(args):
	if _show_native_popup_callback != null:
		_show_native_popup_callback.call(false)
		_show_native_popup_callback = null

func _get_seconds_left(js_time_left, period):
	if typeof(js_time_left) != TYPE_OBJECT:
		return null

	var seconds = js_time_left[period]
	var seconds_type = typeof(seconds)
	if seconds_type == TYPE_INT or seconds_type == TYPE_FLOAT:
		return int(seconds)

	return null
