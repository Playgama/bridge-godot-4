signal state_changed
signal room_left
signal room_updated
signal player_joined
signal player_left
signal player_updated
signal host_changed
signal message_received
signal sync_state_received

var is_supported : get = _is_supported_getter
var state : get = _state_getter
var is_in_room : get = _is_in_room_getter
var is_host : get = _is_host_getter
var player_id : get = _player_id_getter
var host_id : get = _host_id_getter
var room_id : get = _room_id_getter
var region : get = _region_getter
var room : get = _room_getter
var players : get = _players_getter
var is_invite_supported : get = _is_invite_supported_getter
var launch_room_id : get = _launch_room_id_getter
var sync_state : get = _sync_state_getter
var last_error : get = _last_error_getter


func _is_supported_getter():
	return false

func _state_getter():
	return Bridge.MultiplayerState.DISCONNECTED

func _is_in_room_getter():
	return false

func _is_host_getter():
	return false

func _player_id_getter():
	return null

func _host_id_getter():
	return null

func _room_id_getter():
	return null

func _region_getter():
	return _region

func _room_getter():
	return null

func _players_getter():
	return []

func _is_invite_supported_getter():
	return false

func _launch_room_id_getter():
	return null

func _sync_state_getter():
	return _sync_state.duplicate(true)

func _last_error_getter():
	return null

# The world is only stored, nothing is sent.
var _sync_state = {}
# A fixed region list; the chosen region is only stored.
var _regions = ["eu", "us", "ap"]
var _region = null


func create_room(options = null, callback = null):
	if callback != null:
		callback.call(false, null)

func join_room(id, options = null, callback = null):
	if callback != null:
		callback.call(false)

func join_or_create_room(options = null, callback = null):
	if callback != null:
		callback.call(false, null)

func get_rooms(options = null, callback = null):
	if callback != null:
		callback.call(false, [])

func get_regions(callback = null):
	if _region == null:
		_region = _regions[0]
	if callback != null:
		callback.call(true, _regions.duplicate())

func invite_to_room(options = null, callback = null):
	if callback != null:
		callback.call(false)

func leave_room():
	pass

func set_region(region):
	if typeof(region) == TYPE_STRING and region != "":
		_region = region

func set_room_open(is_open):
	pass

func set_room_visible(is_visible):
	pass

func set_room_properties(properties):
	pass

func set_player_properties(properties):
	pass

func send(type, data = null, options = null):
	pass

func set_sync_state(state):
	if typeof(state) == TYPE_DICTIONARY:
		_sync_state = state.duplicate(true)
