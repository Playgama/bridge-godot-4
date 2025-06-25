extends Node

func _on_platform_button_pressed():
	get_tree().change_scene_to_file("res://examples/scenes/platform.tscn")

func _on_device_button_pressed():
	get_tree().change_scene_to_file("res://examples/scenes/device.tscn")

func _on_player_button_pressed():
	get_tree().change_scene_to_file("res://examples/scenes/player.tscn")

func _on_game_button_pressed():
	get_tree().change_scene_to_file("res://examples/scenes/game.tscn")

func _on_storage_button_pressed():
	get_tree().change_scene_to_file("res://examples/scenes/storage.tscn")

func _on_advertisement_button_pressed():
	get_tree().change_scene_to_file("res://examples/scenes/advertisement.tscn")

func _on_social_button_pressed():
	get_tree().change_scene_to_file("res://examples/scenes/social.tscn")

func _on_leaderboards_button_pressed():
	get_tree().change_scene_to_file("res://examples/scenes/leaderboards.tscn")

func _on_payments_button_pressed():
	get_tree().change_scene_to_file("res://examples/scenes/payments.tscn")

func _on_achievements_button_pressed():
	get_tree().change_scene_to_file("res://examples/scenes/achievements.tscn")

func _on_remote_config_button_pressed():
	get_tree().change_scene_to_file("res://examples/scenes/remote_config.tscn")
