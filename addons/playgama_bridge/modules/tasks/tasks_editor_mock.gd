func get_tasks(callback = null):
	if callback != null:
		callback.call(false, [])

func add_progress(metric, amount = 1, callback = null):
	if callback != null:
		callback.call(false)

func claim_reward(task_id, callback = null):
	if callback != null:
		callback.call(false)
