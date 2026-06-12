
extends DetailedSceneBase


@onready var is_achievements_supported_label = $MarginContainer2/VBoxContainer/IsAchievementsSupported
@onready var is_get_list_supported_label = $MarginContainer2/VBoxContainer/IsGetListSupported
@onready var is_native_popup_supported_label = $MarginContainer2/VBoxContainer/IsNativePopupSupported
@onready var achievement_key_input = $MarginContainer2/VBoxContainer/HBoxContainer2/AchievementKeyInput
@onready var achievement_name_input = $MarginContainer2/VBoxContainer/HBoxContainer2/AchievementNameInput

func _ready():
	is_achievements_supported_label.text = "Is Achievements Supported: " + str(Bridge.achievements.is_supported)
	is_get_list_supported_label.text = "Is Get List Supported: " + str(Bridge.achievements.is_get_list_supported)
	is_native_popup_supported_label.text = "Is Native Popup Supported: " + str(Bridge.achievements.is_native_popup_supported)

func _on_unlock_button_pressed():
	# Platform-specific data is resolved from the achievements
	# section of playgama-bridge-config.json by the game-level id
	Bridge.achievements.unlock(achievement_key_input.text, Callable(self, "_on_unlock_completed"))

func _on_unlock_completed(success):
	print(success)


func _on_get_list_button_pressed():
	Bridge.achievements.get_list(Callable(self, "_on_get_list_completed"))

func _on_get_list_completed(success, list):
	print(success)

	for item in list:
		print("id:" + str(item.id))
		print("name:" + str(item.name))
		print("description:" + str(item.description))
		print("unlocked:" + str(item.unlocked))


func _on_show_native_popup_button_pressed():
	Bridge.achievements.show_native_popup(Callable(self, "_on_show_native_popup_completed"))

func _on_show_native_popup_completed(success):
	print(success)
