var _js_analytics = null

var _utils = load("res://addons/playgama_bridge/utils.gd").new()

func _init(js_analytics):
	_js_analytics = js_analytics

# Sends a game event. The name and the payload are entirely up to the game —
# they are never matched against the SDK's own event names.
func send(event_name, data = null):
	if data != null:
		var js_data = _utils.convert_to_js(data)
		_js_analytics.send(event_name, js_data)
	else:
		_js_analytics.send(event_name)
