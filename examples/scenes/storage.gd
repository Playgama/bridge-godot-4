extends DetailedSceneBase


@onready var coins_input = $MarginContainer2/VBoxContainer/HBoxContainer2/CoinsInput
@onready var level_id_input = $MarginContainer2/VBoxContainer/HBoxContainer2/LevelIdInput
@onready var is_tutorial_completed_checkbox = $MarginContainer2/VBoxContainer/HBoxContainer2/TutorialCheckbox


func _on_load_data_button_pressed():
	Bridge.storage.get(["coins_count", "level_id", "is_tutorial_completed"], Callable(self, "_on_storage_get_completed"))

func _on_save_data_button_pressed():
	Bridge.storage.set(["coins_count", "level_id", "is_tutorial_completed"], [coins_input.text, level_id_input.text, is_tutorial_completed_checkbox.button_pressed], Callable(self, "_on_storage_set_completed"))

func _on_delete_data_button_pressed():
	Bridge.storage.delete(["coins_count", "level_id", "is_tutorial_completed"], Callable(self, "_on_storage_delete_completed"))


func _on_storage_get_completed(success, data):
	if success:
		print(data)

		if data[0] != null:
			coins_input.text = str(data[0])
		else:
			coins_input.text = ""
			print("Coins is null")

		if data[1] != null:
			level_id_input.text = str(data[1])
		else:
			level_id_input.text = ""
			print("Level ID is null")

		if data[2] != null:
			is_tutorial_completed_checkbox.button_pressed = data[2].to_lower() == "true"
		else:
			is_tutorial_completed_checkbox.button_pressed = false
			print("Is Tutorial Completed is null")

func _on_storage_set_completed(success):
	coins_input.text = ""
	level_id_input.text = ""
	is_tutorial_completed_checkbox.button_pressed = false
	print("On Storage Set Completed, success: ", success)

func _on_storage_delete_completed(success):
	coins_input.text = ""
	level_id_input.text = ""
	is_tutorial_completed_checkbox.button_pressed = false
	print("On Storage Delete Completed, success: ", success)
