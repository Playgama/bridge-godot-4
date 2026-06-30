extends DetailedSceneBase


@onready var is_visible_label = $MarginContainer2/VBoxContainer/HBoxContainer/IsVisibleLabel

func _ready():
	_update_is_visible_label()


func _on_show_button_pressed():
	Bridge.cross_promo.show()
	_update_is_visible_label()

func _on_hide_button_pressed():
	Bridge.cross_promo.hide()
	_update_is_visible_label()

func _on_get_games_list_button_pressed():
	Bridge.cross_promo.get_games(Callable(self, "_on_get_games_list_completed"))

func _on_get_games_list_completed(success, games):
	print(success)

	for game in games:
		print("ID: " + str(game.get("id")))
		print("Name: " + str(game.get("name")))
		print("URL: " + str(game.get("url")))
		print("Icon URL: " + str(game.get("iconUrl")))
		print("Cover URL: " + str(game.get("coverUrl")))

func _update_is_visible_label():
	is_visible_label.text = "Is Visible: " + str(Bridge.cross_promo.is_visible)
