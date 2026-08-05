extends DetailedSceneBase


@onready var output_label = $MarginContainer2/VBoxContainer/Output


func _ready():
	output_label.text = "isSupported -> " + str(Bridge.notifications.is_supported)


func _on_is_supported_button_pressed():
	output_label.text = "isSupported -> " + str(Bridge.notifications.is_supported)


func _on_schedule_button_pressed():
	# The payload of the notification the game was launched from is available
	# via Bridge.platform.payload
	Bridge.notifications.schedule({
		"id": "come_back",
		"title": "Ready for another round?",
		"description": "Jump back in right where you left off.",
		"delaySeconds": 86400,
		"payload": "come_back"
	}, Callable(self, "_on_schedule_completed"))


func _on_schedule_completed(success):
	output_label.text = "schedule -> " + str(success)


func _on_cancel_button_pressed():
	Bridge.notifications.cancel("come_back", Callable(self, "_on_cancel_completed"))


func _on_cancel_completed(success):
	output_label.text = "cancel -> " + str(success)


func _on_cancel_all_button_pressed():
	Bridge.notifications.cancel_all(Callable(self, "_on_cancel_all_completed"))


func _on_cancel_all_completed(success):
	output_label.text = "cancelAll -> " + str(success)
