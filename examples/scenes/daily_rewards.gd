extends DetailedSceneBase


@onready var output_label = $MarginContainer2/VBoxContainer/Output


func _ready():
	_refresh()


func _refresh():
	Bridge.daily_rewards.get_rewards(Callable(self, "_on_get_rewards_completed"))


func _on_get_rewards_button_pressed():
	_refresh()


func _on_get_rewards_completed(success, rewards):
	if not success:
		output_label.text = "getRewards failed"
		return

	var text = "rewards: "
	for reward in rewards:
		text += str(reward) + " "
	output_label.text = text


func _on_get_current_day_button_pressed():
	Bridge.daily_rewards.get_current_day(Callable(self, "_on_get_current_day_completed"))


func _on_get_current_day_completed(success, day):
	if not success:
		output_label.text = "getCurrentDay failed"
		return

	output_label.text = "currentDay -> " + str(day)


func _on_get_current_reward_button_pressed():
	Bridge.daily_rewards.get_current_reward(Callable(self, "_on_get_current_reward_completed"))


func _on_get_current_reward_completed(success, reward):
	if not success:
		output_label.text = "getCurrentReward failed"
		return

	output_label.text = "currentReward -> " + str(reward)


func _on_claim_current_reward_button_pressed():
	# claim_current_reward resolves to a boolean: whether the reward was claimed
	Bridge.daily_rewards.claim_current_reward(Callable(self, "_on_claim_current_reward_completed"))


func _on_claim_current_reward_completed(claimed):
	output_label.text = "claimCurrentReward -> " + str(claimed)
