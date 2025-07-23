signal audio_state_changed
signal pause_state_changed

var id : get = _id_getter
var payload : get = _payload_getter
var language : get = _language_getter
var tld : get = _tld_getter
var is_audio_enabled : get = _is_audio_enabled_getter
var is_get_all_games_supported : get = _is_get_all_games_supported_getter
var is_get_game_by_id_supported : get = _is_get_game_by_id_supported_getter

func _id_getter():
	return "mock"

func _payload_getter():
	return null

func _language_getter():
	return "en"

func _tld_getter():
	return null

func _is_audio_enabled_getter():
	return true

func _is_get_all_games_supported_getter():
	return false

func _is_get_game_by_id_supported_getter():
	return false

func send_message(message):
	pass

func get_server_time(callback):
	if callback != null:
		callback.call(Time.get_unix_time_from_system() * 1000)

func get_all_games(callback):
	pass

func get_game_by_id(game_id, callback):
	pass
