func get_rewards(callback = null):
	if callback != null:
		callback.call(false, [])

func get_current_day(callback = null):
	if callback != null:
		callback.call(false, 0)

func get_current_reward(callback = null):
	if callback != null:
		callback.call(false, null)

func claim_current_reward(callback = null):
	if callback != null:
		callback.call(false)
