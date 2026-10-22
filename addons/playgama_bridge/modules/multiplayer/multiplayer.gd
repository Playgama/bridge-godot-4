signal state_changed
signal room_left
signal room_updated
signal player_joined
signal player_left
signal player_updated
signal host_changed
signal message_received

var is_supported : get = _is_supported_getter
var state : get = _state_getter
var is_in_room : get = _is_in_room_getter
var is_host : get = _is_host_getter
var player_id : get = _player_id_getter
var host_id : get = _host_id_getter
var room_id : get = _room_id_getter
var room : get = _room_getter
var players : get = _players_getter
var is_invite_supported : get = _is_invite_supported_getter
var launch_room_id : get = _launch_room_id_getter
# Error code of the last failed request, e.g. MULTIPLAYER_ROOM_FULL; null after a success.
var last_error : get = _last_error_getter


func _is_supported_getter():
	return _js_multiplayer.isSupported

func _state_getter():
	return _js_multiplayer.state

func _is_in_room_getter():
	return _js_multiplayer.isInRoom

func _is_host_getter():
	return _js_multiplayer.isHost

func _player_id_getter():
	return _js_multiplayer.playerId

func _host_id_getter():
	return _js_multiplayer.hostId

func _room_id_getter():
	return _js_multiplayer.roomId

func _room_getter():
	_update_cache()
	return _room.duplicate(true) if _room != null else null

func _players_getter():
	_update_cache()
	return _players.duplicate(true)

func _is_invite_supported_getter():
	return _js_multiplayer.isInviteSupported

# The room code from the invite link the game was opened with, null otherwise.
func _launch_room_id_getter():
	return _js_multiplayer.launchRoomId

func _last_error_getter():
	return _last_error

var _js_multiplayer = null
var _js_json = JavaScriptBridge.get_interface("JSON")
# room and players are read from JS again only after a multiplayer event
var _room = null
var _players = []
var _is_cache_outdated = true
var _last_error = null
var _utils = load("res://addons/playgama_bridge/utils.gd").new()
var _js_on_state_changed = JavaScriptBridge.create_callback(self._on_state_changed)
var _js_on_room_left = JavaScriptBridge.create_callback(self._on_room_left)
var _js_on_room_updated = JavaScriptBridge.create_callback(self._on_room_updated)
var _js_on_player_joined = JavaScriptBridge.create_callback(self._on_player_joined)
var _js_on_player_left = JavaScriptBridge.create_callback(self._on_player_left)
var _js_on_player_updated = JavaScriptBridge.create_callback(self._on_player_updated)
var _js_on_host_changed = JavaScriptBridge.create_callback(self._on_host_changed)
var _js_on_message_received = JavaScriptBridge.create_callback(self._on_message_received)
var _create_room_callback = null
var _js_create_room_then = JavaScriptBridge.create_callback(self._on_js_create_room_then)
var _js_create_room_catch = JavaScriptBridge.create_callback(self._on_js_create_room_catch)
var _join_room_callback = null
var _js_join_room_then = JavaScriptBridge.create_callback(self._on_js_join_room_then)
var _js_join_room_catch = JavaScriptBridge.create_callback(self._on_js_join_room_catch)
var _join_or_create_room_callback = null
var _js_join_or_create_room_then = JavaScriptBridge.create_callback(self._on_js_join_or_create_room_then)
var _js_join_or_create_room_catch = JavaScriptBridge.create_callback(self._on_js_join_or_create_room_catch)
var _get_rooms_callback = null
var _js_get_rooms_then = JavaScriptBridge.create_callback(self._on_js_get_rooms_then)
var _js_get_rooms_catch = JavaScriptBridge.create_callback(self._on_js_get_rooms_catch)
var _invite_to_room_callback = null
var _js_invite_to_room_then = JavaScriptBridge.create_callback(self._on_js_invite_to_room_then)
var _js_invite_to_room_catch = JavaScriptBridge.create_callback(self._on_js_invite_to_room_catch)


# The callback receives (success, room_id).
func create_room(options = null, callback = null):
	if _create_room_callback != null:
		return

	_create_room_callback = callback
	_last_error = null

	var promise = null
	if options != null:
		promise = _js_multiplayer.createRoom(_utils.convert_to_js(options))
	else:
		promise = _js_multiplayer.createRoom()

	promise.then(_js_create_room_then).catch(_js_create_room_catch)

func join_room(id, options = null, callback = null):
	if _join_room_callback != null:
		return

	_join_room_callback = callback
	_last_error = null

	var promise = null
	if options != null:
		promise = _js_multiplayer.joinRoom(id, _utils.convert_to_js(options))
	else:
		promise = _js_multiplayer.joinRoom(id)

	promise.then(_js_join_room_then).catch(_js_join_room_catch)

# The callback receives (success, room_id).
func join_or_create_room(options = null, callback = null):
	if _join_or_create_room_callback != null:
		return

	_join_or_create_room_callback = callback
	_last_error = null

	var promise = null
	if options != null:
		promise = _js_multiplayer.joinOrCreateRoom(_utils.convert_to_js(options))
	else:
		promise = _js_multiplayer.joinOrCreateRoom()

	promise.then(_js_join_or_create_room_then).catch(_js_join_or_create_room_catch)

# The callback receives (success, rooms).
func get_rooms(options = null, callback = null):
	if _get_rooms_callback != null:
		return

	_get_rooms_callback = callback
	_last_error = null

	var promise = null
	if options != null:
		promise = _js_multiplayer.getRooms(_utils.convert_to_js(options))
	else:
		promise = _js_multiplayer.getRooms()

	promise.then(_js_get_rooms_then).catch(_js_get_rooms_catch)

func invite_to_room(options = null, callback = null):
	if _invite_to_room_callback != null:
		return

	_invite_to_room_callback = callback
	_last_error = null

	var promise = null
	if options != null:
		promise = _js_multiplayer.inviteToRoom(_utils.convert_to_js(options))
	else:
		promise = _js_multiplayer.inviteToRoom()

	promise.then(_js_invite_to_room_then).catch(_js_invite_to_room_catch)

func leave_room():
	_js_multiplayer.leaveRoom()

# Host only.
func set_room_open(is_open):
	_js_multiplayer.setRoomOpen(is_open)

# Host only.
func set_room_visible(is_visible):
	_js_multiplayer.setRoomVisible(is_visible)

# Host only. Keys are merged, a null value removes the key.
func set_room_properties(properties):
	_js_multiplayer.setRoomProperties(_utils.convert_to_js(properties))

# Keys are merged, a null value removes the key.
func set_player_properties(properties):
	_js_multiplayer.setPlayerProperties(_utils.convert_to_js(properties))

# data: a flat Dictionary (string, number or bool values).
# options.to: one of Bridge.MultiplayerTarget, a player id or an array of player ids.
func send(type, data = null, options = null):
	var js_data = _gd_to_js(data)
	if options != null:
		_js_multiplayer.send(type, js_data, _utils.convert_to_js(options))
	else:
		_js_multiplayer.send(type, js_data)


func _init(js_multiplayer):
	_js_multiplayer = js_multiplayer
	_js_multiplayer.on('multiplayer_state_changed', _js_on_state_changed)
	_js_multiplayer.on('multiplayer_room_left', _js_on_room_left)
	_js_multiplayer.on('multiplayer_room_updated', _js_on_room_updated)
	_js_multiplayer.on('multiplayer_player_joined', _js_on_player_joined)
	_js_multiplayer.on('multiplayer_player_left', _js_on_player_left)
	_js_multiplayer.on('multiplayer_player_updated', _js_on_player_updated)
	_js_multiplayer.on('multiplayer_host_changed', _js_on_host_changed)
	_js_multiplayer.on('multiplayer_message_received', _js_on_message_received)

func _on_state_changed(args):
	_is_cache_outdated = true
	emit_signal("state_changed", args[0])

func _on_room_left(args):
	_is_cache_outdated = true
	emit_signal("room_left", args[0])

func _on_room_updated(args):
	_is_cache_outdated = true
	emit_signal("room_updated", _js_to_gd(args[0]))

func _on_player_joined(args):
	_is_cache_outdated = true
	emit_signal("player_joined", _js_to_gd(args[0]))

func _on_player_left(args):
	_is_cache_outdated = true
	emit_signal("player_left", _js_to_gd(args[0]))

func _on_player_updated(args):
	_is_cache_outdated = true
	emit_signal("player_updated", _js_to_gd(args[0]))

# The new host, null when the room has none.
func _on_host_changed(args):
	_is_cache_outdated = true
	emit_signal("host_changed", _js_to_gd(args[0]))

# The message is a dictionary: { type, data, from }, data is always a Dictionary.
func _on_message_received(args):
	var message = _js_to_gd(args[0])
	if typeof(message.get("data")) != TYPE_DICTIONARY:
		message["data"] = {}
	emit_signal("message_received", message)

func _on_js_create_room_then(args):
	if _create_room_callback != null:
		_create_room_callback.call(true, args[0])
		_create_room_callback = null

func _on_js_create_room_catch(args):
	_last_error = _get_error_code(args[0])
	if _create_room_callback != null:
		_create_room_callback.call(false, null)
		_create_room_callback = null

func _on_js_join_room_then(args):
	if _join_room_callback != null:
		_join_room_callback.call(true)
		_join_room_callback = null

func _on_js_join_room_catch(args):
	_last_error = _get_error_code(args[0])
	if _join_room_callback != null:
		_join_room_callback.call(false)
		_join_room_callback = null

func _on_js_join_or_create_room_then(args):
	if _join_or_create_room_callback != null:
		_join_or_create_room_callback.call(true, args[0])
		_join_or_create_room_callback = null

func _on_js_join_or_create_room_catch(args):
	_last_error = _get_error_code(args[0])
	if _join_or_create_room_callback != null:
		_join_or_create_room_callback.call(false, null)
		_join_or_create_room_callback = null

func _on_js_get_rooms_then(args):
	if _get_rooms_callback != null:
		_get_rooms_callback.call(true, _js_to_gd(args[0]))
		_get_rooms_callback = null

func _on_js_get_rooms_catch(args):
	_last_error = _get_error_code(args[0])
	if _get_rooms_callback != null:
		_get_rooms_callback.call(false, [])
		_get_rooms_callback = null

func _on_js_invite_to_room_then(args):
	if _invite_to_room_callback != null:
		_invite_to_room_callback.call(true)
		_invite_to_room_callback = null

func _on_js_invite_to_room_catch(args):
	_last_error = _get_error_code(args[0])
	if _invite_to_room_callback != null:
		_invite_to_room_callback.call(false)
		_invite_to_room_callback = null


func _update_cache():
	if not _is_cache_outdated:
		return

	_room = _js_to_gd(_js_multiplayer.room)
	_players = _js_to_gd(_js_multiplayer.players)
	_is_cache_outdated = false

func _get_error_code(error):
	if typeof(error) == TYPE_OBJECT and error != null and error.code != null:
		return error.code

	return null

# JS objects (room, players, message data) are free JSON: one stringify call and the native
# parser are much cheaper than reading every field through JavaScriptBridge.
func _js_to_gd(value):
	if typeof(value) != TYPE_OBJECT or value == null:
		return value

	return _restore_ints(JSON.parse_string(_js_json.stringify(value)))

func _gd_to_js(value):
	var value_type = typeof(value)
	if value_type == TYPE_DICTIONARY or value_type == TYPE_ARRAY:
		return _js_json.parse(JSON.stringify(value))

	return value

# The JSON parser reads every number as float, JavaScriptBridge keeps whole numbers as int.
func _restore_ints(value):
	match typeof(value):
		TYPE_FLOAT:
			if value == floor(value) and abs(value) < 9007199254740992.0:
				return int(value)
		TYPE_DICTIONARY:
			for key in value:
				value[key] = _restore_ints(value[key])
		TYPE_ARRAY:
			for i in range(value.size()):
				value[i] = _restore_ints(value[i])

	return value
