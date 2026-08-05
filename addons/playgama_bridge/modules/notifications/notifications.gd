var is_supported : get = _is_supported_getter


func _is_supported_getter():
	return _js_notifications.isSupported

var _js_notifications = null
var _utils = load("res://addons/playgama_bridge/utils.gd").new()
var _schedule_callback = null
var _js_schedule_then = JavaScriptBridge.create_callback(self._on_js_schedule_then)
var _js_schedule_catch = JavaScriptBridge.create_callback(self._on_js_schedule_catch)
var _cancel_callback = null
var _js_cancel_then = JavaScriptBridge.create_callback(self._on_js_cancel_then)
var _js_cancel_catch = JavaScriptBridge.create_callback(self._on_js_cancel_catch)
var _cancel_all_callback = null
var _js_cancel_all_then = JavaScriptBridge.create_callback(self._on_js_cancel_all_then)
var _js_cancel_all_catch = JavaScriptBridge.create_callback(self._on_js_cancel_all_catch)


# The payload of the notification the game was launched from is delivered
# through the regular platform payload — see bridge.platform.payload.
func schedule(notification, callback = null):
	if _schedule_callback != null:
		return

	_schedule_callback = callback

	var js_notification = null
	if notification:
		js_notification = _utils.convert_to_js(notification)

	_js_notifications.schedule(js_notification).then(_js_schedule_then).catch(_js_schedule_catch)


func cancel(id, callback = null):
	if _cancel_callback != null:
		return

	_cancel_callback = callback
	_js_notifications.cancel(id).then(_js_cancel_then).catch(_js_cancel_catch)


func cancel_all(callback = null):
	if _cancel_all_callback != null:
		return

	_cancel_all_callback = callback
	_js_notifications.cancelAll().then(_js_cancel_all_then).catch(_js_cancel_all_catch)


func _init(js_notifications):
	_js_notifications = js_notifications

func _on_js_schedule_then(args):
	if _schedule_callback != null:
		_schedule_callback.call(true)
		_schedule_callback = null

func _on_js_schedule_catch(args):
	if _schedule_callback != null:
		_schedule_callback.call(false)
		_schedule_callback = null

func _on_js_cancel_then(args):
	if _cancel_callback != null:
		_cancel_callback.call(true)
		_cancel_callback = null

func _on_js_cancel_catch(args):
	if _cancel_callback != null:
		_cancel_callback.call(false)
		_cancel_callback = null

func _on_js_cancel_all_then(args):
	if _cancel_all_callback != null:
		_cancel_all_callback.call(true)
		_cancel_all_callback = null

func _on_js_cancel_all_catch(args):
	if _cancel_all_callback != null:
		_cancel_all_callback.call(false)
		_cancel_all_callback = null
