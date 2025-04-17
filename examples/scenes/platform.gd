extends DetailedSceneBase


@onready var id_label = $MarginContainer2/VBoxContainer/PlatformID
@onready var language_label = $MarginContainer2/VBoxContainer/Language
@onready var payload_label = $MarginContainer2/VBoxContainer/Payload
@onready var tld_label = $MarginContainer2/VBoxContainer/Tld
@onready var server_time_label = $MarginContainer2/VBoxContainer/HBoxContainer4/ServerTimeLabel
@onready var is_get_all_games_supported = $MarginContainer2/VBoxContainer/HBoxContainer5/IsGetAllGamesSupported
@onready var is_get_game_by_id_supported = $MarginContainer2/VBoxContainer/HBoxContainer6/IsGetGameByIdSupported
@onready var game_id = $MarginContainer2/VBoxContainer/HBoxContainer6/GameIdInput

func _ready():
	id_label.text = "Platform ID: " + Bridge.platform.id
	language_label.text = "Language: " + Bridge.platform.language
	payload_label.text = "Payload: " + str(Bridge.platform.payload)
	tld_label.text = "TLD: " + str(Bridge.platform.tld)


func _on_send_game_ready_button_pressed():
	Bridge.platform.send_message(Bridge.PlatformMessage.GAME_READY)

func _on_send_in_game_loading_started_button_pressed():
	Bridge.platform.send_message(Bridge.PlatformMessage.IN_GAME_LOADING_STARTED)

func _on_send_in_game_loading_stopped_button_pressed():
	Bridge.platform.send_message(Bridge.PlatformMessage.IN_GAME_LOADING_STOPPED)

func _on_send_gameplay_started_button_pressed():
	Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STARTED)

func _on_send_gameplay_stopped_button_pressed():
	Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STOPPED)

func _on_send_player_got_achievement_button_pressed():
	Bridge.platform.send_message(Bridge.PlatformMessage.PLAYER_GOT_ACHIEVEMENT)

func _on_get_server_time_button_pressed():
	Bridge.platform.get_server_time(Callable(self, "_on_get_server_time_completed"))

func _on_get_server_time_completed(milliseconds):
	server_time_label.text = "Server Time (UTC): " + str(milliseconds)

func _on_get_all_games_button_pressed():
	Bridge.platform.get_all_games(Callable(self, "_on_get_all_games_completed"))

func _on_get_all_games_completed(success, games):
	print(success)

	match Bridge.platform.id:
		"yandex":
			for game in games:
				print("App ID: " + str(game.appID))
				print("Title: " + str(game.title))
				print("URL: " + str(game.url))
				print("Cover URL: " + str(game.coverURL))
				print("Icon URL: " + str(game.iconURL))

func _on_get_game_by_id_button_pressed():
	var options

	options = {
		"gameId": game_id.text
	}

	Bridge.platform.get_game_by_id(options, Callable(self, "_on_get_game_by_id_completed"))

func _on_get_game_by_id_completed(success, game):
	print(success)

	match Bridge.platform.id:
		"yandex":
			print("App ID: " + str(game.appID))
			print("Title: " + str(game.title))
			print("URL: " + str(game.url))
			print("Cover URL: " + str(game.coverURL))
			print("Icon URL: " + str(game.iconURL))
			print("Is Available: " + str(game.isAvailable))
