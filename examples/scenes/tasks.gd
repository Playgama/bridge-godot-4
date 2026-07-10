extends DetailedSceneBase


@onready var output_label = $MarginContainer2/VBoxContainer/Output
@onready var metric_input = $MarginContainer2/VBoxContainer/HBoxContainer2/MetricInput
@onready var amount_input = $MarginContainer2/VBoxContainer/HBoxContainer2/AmountInput
@onready var task_id_input = $MarginContainer2/VBoxContainer/HBoxContainer3/TaskIdInput


func _ready():
	_refresh()


func _refresh():
	Bridge.tasks.get_tasks(Callable(self, "_on_get_tasks_completed"))


func _on_get_tasks_button_pressed():
	_refresh()


func _on_get_tasks_completed(success, list):
	if not success:
		output_label.text = "getTasks failed"
		return

	var text = ""
	for task in list:
		text += str(task.id) + " [" + str(task.type) + "] completed=" + str(task.completed) + " claimed=" + str(task.claimed) + "\n"
		for target in task.targets:
			text += "    " + str(target.id) + ": " + str(target.progress) + "/" + str(target.amount) + "\n"
	output_label.text = text


func _on_add_progress_button_pressed():
	var amount = int(amount_input.text) if amount_input.text != "" else 1
	# add_progress resolves without data; refresh the list to see updated progress
	Bridge.tasks.add_progress(metric_input.text, amount, Callable(self, "_on_add_progress_completed"))


func _on_add_progress_completed(success):
	print("addProgress success: " + str(success))
	_refresh()


func _on_claim_reward_button_pressed():
	# claim_reward resolves to a boolean; rewards to grant are on the task (task.rewards)
	Bridge.tasks.claim_reward(task_id_input.text, Callable(self, "_on_claim_reward_completed"))


func _on_claim_reward_completed(claimed):
	output_label.text = "claimReward -> " + str(claimed)
