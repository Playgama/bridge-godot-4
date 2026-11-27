extends DetailedSceneBase


@onready var leaderboards_type_label = $MarginContainer2/VBoxContainer/LeaderboardsType


func _ready():
	leaderboards_type_label.text = "Leaderboards Type: " + str(Bridge.leaderboards.type)


func _on_set_score_button_pressed():
	var leaderboard_id = ""
	var player_score = 42
	Bridge.leaderboards.set_score(leaderboard_id, player_score, Callable(self, "_on_set_score_completed"))

func _on_set_score_completed(success):
	print(success)


func _on_get_entries_button_pressed():
	var leaderboard_id = ""
	# The permanent standings by default; pass a period from get_info() to read others:
	# Bridge.leaderboards.get_entries(leaderboard_id, callback, Bridge.LeaderboardPeriod.DAILY)
	Bridge.leaderboards.get_entries(leaderboard_id , Callable(self, "_on_get_entries_completed"))

func _on_get_entries_completed(success, entries):
	print(success)

	for entry in entries:
		print("ID: " + str(entry.id))
		print("Name: " + str(entry.name))
		print("Score: " + str(entry.score))
		print("Rank: " + str(entry.rank))
		print("Photo: " + str(entry.photo))


func _on_get_info_button_pressed():
	var leaderboard_id = ""
	Bridge.leaderboards.get_info(leaderboard_id, Callable(self, "_on_get_info_completed"))

func _on_get_info_completed(success, info):
	print(success)

	if success:
		print("Score Mode: " + str(info.score_mode))
		print("Periods: " + str(info.periods))
		print("Daily Time Left: " + str(info.time_left.daily))
		print("Weekly Time Left: " + str(info.time_left.weekly))
		print("Monthly Time Left: " + str(info.time_left.monthly))


func _on_show_native_popup_button_pressed():
	var leaderboard_id = ""
	Bridge.leaderboards.show_native_popup(leaderboard_id , Callable(self, "_on_show_native_popup_completed"))

func _on_show_native_popup_completed(success):
	print(success)
