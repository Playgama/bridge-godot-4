var _js_daily_rewards = null

var _get_rewards_callback = null
var _js_get_rewards_then = JavaScriptBridge.create_callback(self._on_js_get_rewards_then)
var _js_get_rewards_catch = JavaScriptBridge.create_callback(self._on_js_get_rewards_catch)

var _get_current_day_callback = null
var _js_get_current_day_then = JavaScriptBridge.create_callback(self._on_js_get_current_day_then)
var _js_get_current_day_catch = JavaScriptBridge.create_callback(self._on_js_get_current_day_catch)

var _get_current_reward_callback = null
var _js_get_current_reward_then = JavaScriptBridge.create_callback(self._on_js_get_current_reward_then)
var _js_get_current_reward_catch = JavaScriptBridge.create_callback(self._on_js_get_current_reward_catch)

var _claim_current_reward_callback = null
var _js_claim_current_reward_then = JavaScriptBridge.create_callback(self._on_js_claim_current_reward_then)
var _js_claim_current_reward_catch = JavaScriptBridge.create_callback(self._on_js_claim_current_reward_catch)


func _init(js_daily_rewards):
	_js_daily_rewards = js_daily_rewards


func get_rewards(callback = null):
	if _get_rewards_callback != null:
		return

	_get_rewards_callback = callback

	_js_daily_rewards.getRewards().then(_js_get_rewards_then).catch(_js_get_rewards_catch)


func get_current_day(callback = null):
	if _get_current_day_callback != null:
		return

	_get_current_day_callback = callback

	_js_daily_rewards.getCurrentDay().then(_js_get_current_day_then).catch(_js_get_current_day_catch)


func get_current_reward(callback = null):
	if _get_current_reward_callback != null:
		return

	_get_current_reward_callback = callback

	_js_daily_rewards.getCurrentReward().then(_js_get_current_reward_then).catch(_js_get_current_reward_catch)


func claim_current_reward(callback = null):
	if _claim_current_reward_callback != null:
		return

	_claim_current_reward_callback = callback

	_js_daily_rewards.claimCurrentReward().then(_js_claim_current_reward_then).catch(_js_claim_current_reward_catch)


func _on_js_get_rewards_then(args):
	if _get_rewards_callback != null:
		_get_rewards_callback.call(true, _js_to_gd(args[0]))
		_get_rewards_callback = null

func _on_js_get_rewards_catch(args):
	if _get_rewards_callback != null:
		_get_rewards_callback.call(false, [])
		_get_rewards_callback = null

func _on_js_get_current_day_then(args):
	if _get_current_day_callback != null:
		var data = args[0]
		var day = int(data) if typeof(data) == TYPE_INT or typeof(data) == TYPE_FLOAT else 0
		_get_current_day_callback.call(true, day)
		_get_current_day_callback = null

func _on_js_get_current_day_catch(args):
	if _get_current_day_callback != null:
		_get_current_day_callback.call(false, 0)
		_get_current_day_callback = null

func _on_js_get_current_reward_then(args):
	if _get_current_reward_callback != null:
		# args[0] is the claimable reward id, or null when nothing can be claimed
		_get_current_reward_callback.call(true, args[0])
		_get_current_reward_callback = null

func _on_js_get_current_reward_catch(args):
	if _get_current_reward_callback != null:
		_get_current_reward_callback.call(false, null)
		_get_current_reward_callback = null

func _on_js_claim_current_reward_then(args):
	if _claim_current_reward_callback != null:
		# args[0] is a boolean: whether the claim succeeded
		_claim_current_reward_callback.call(args[0] == true)
		_claim_current_reward_callback = null

func _on_js_claim_current_reward_catch(args):
	if _claim_current_reward_callback != null:
		_claim_current_reward_callback.call(false)
		_claim_current_reward_callback = null


# Recursively converts a JS value (objects, arrays, scalars) into native GDScript
# dictionaries/arrays. getRewards resolves to an array of reward ids, which has to
# be copied across the FFI before it can be used from GDScript.
func _js_to_gd(value):
	if typeof(value) == TYPE_OBJECT and value != null:
		if JavaScriptBridge.get_interface("Array").isArray(value):
			var array = []
			for i in range(value.length):
				array.append(_js_to_gd(value[i]))
			return array
		else:
			var keys = JavaScriptBridge.get_interface("Object").keys(value)
			var dict = {}
			for j in range(keys.length):
				var key = keys[j]
				dict[key] = _js_to_gd(value[key])
			return dict
	else:
		return value
