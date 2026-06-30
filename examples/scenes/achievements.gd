
extends DetailedSceneBase


@onready var achievement_key_input = $MarginContainer2/VBoxContainer/HBoxContainer2/AchievementKeyInput

func _on_unlock_button_pressed():
	Bridge.achievements.unlock(achievement_key_input.text, Callable(self, "_on_unlock_completed"))

func _on_unlock_completed(success):
	print(success)


func _on_get_list_button_pressed():
	Bridge.achievements.get_achievements(Callable(self, "_on_get_list_completed"))

func _on_get_list_completed(success, list):
	print(success)

	for item in list:
		print("id:" + str(item.id))
		print("name:" + str(item.name))
		print("description:" + str(item.description))
		print("unlocked:" + str(item.unlocked))
