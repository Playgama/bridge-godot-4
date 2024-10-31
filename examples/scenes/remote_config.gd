extends DetailedSceneBase


@onready var is_remote_config_supported_label = $MarginContainer2/VBoxContainer/IsRemoteConfigSupported


func _ready():
	is_remote_config_supported_label.text = "Is Remote Config Supported: " + str(Bridge.remote_config.is_supported)


func _on_get_button_pressed():
	var options
	
	match Bridge.platform.id:
		"yandex":
			options = {
				"clientFeatures": [
					{ "name": "player_coins", "value": "42" },
					{ "name": "player_level", "value": "dungeon_123" },
				]
			}

	Bridge.remote_config.get(options, Callable(self, "_on_remote_config_get_completed"))

func _on_remote_config_get_completed(success, data):
	print(success)
	print(data)
