var _js_tasks = null

var _get_tasks_callback = null
var _js_get_tasks_then = JavaScriptBridge.create_callback(self._on_js_get_tasks_then)
var _js_get_tasks_catch = JavaScriptBridge.create_callback(self._on_js_get_tasks_catch)

var _add_progress_callback = null
var _js_add_progress_then = JavaScriptBridge.create_callback(self._on_js_add_progress_then)
var _js_add_progress_catch = JavaScriptBridge.create_callback(self._on_js_add_progress_catch)

var _claim_reward_callback = null
var _js_claim_reward_then = JavaScriptBridge.create_callback(self._on_js_claim_reward_then)
var _js_claim_reward_catch = JavaScriptBridge.create_callback(self._on_js_claim_reward_catch)


func _init(js_tasks):
	_js_tasks = js_tasks


func get_tasks(callback = null):
	if _get_tasks_callback != null:
		return

	_get_tasks_callback = callback

	_js_tasks.getTasks().then(_js_get_tasks_then).catch(_js_get_tasks_catch)


func add_progress(metric, amount = 1, callback = null):
	if _add_progress_callback != null:
		return

	_add_progress_callback = callback

	_js_tasks.addProgress(metric, amount).then(_js_add_progress_then).catch(_js_add_progress_catch)


func claim_reward(task_id, callback = null):
	if _claim_reward_callback != null:
		return

	_claim_reward_callback = callback

	_js_tasks.claimReward(task_id).then(_js_claim_reward_then).catch(_js_claim_reward_catch)


func _on_js_get_tasks_then(args):
	if _get_tasks_callback != null:
		_get_tasks_callback.call(true, _js_to_gd(args[0]))
		_get_tasks_callback = null

func _on_js_get_tasks_catch(args):
	if _get_tasks_callback != null:
		_get_tasks_callback.call(false, [])
		_get_tasks_callback = null

func _on_js_add_progress_then(args):
	if _add_progress_callback != null:
		_add_progress_callback.call(true)
		_add_progress_callback = null

func _on_js_add_progress_catch(args):
	if _add_progress_callback != null:
		_add_progress_callback.call(false)
		_add_progress_callback = null

func _on_js_claim_reward_then(args):
	if _claim_reward_callback != null:
		# args[0] is a boolean: whether the claim succeeded
		_claim_reward_callback.call(args[0] == true)
		_claim_reward_callback = null

func _on_js_claim_reward_catch(args):
	if _claim_reward_callback != null:
		_claim_reward_callback.call(false)
		_claim_reward_callback = null


# Recursively converts a JS value (objects, arrays, scalars) into native GDScript
# dictionaries/arrays. The shared achievements converter only copies one level,
# which is not enough for tasks whose targets/rewards are nested arrays of objects.
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
