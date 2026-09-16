var is_share_supported : get = _is_share_supported_getter
var is_join_community_supported : get = _is_join_community_supported_getter
var is_invite_friends_supported : get = _is_invite_friends_supported_getter
var is_create_post_supported : get = _is_create_post_supported_getter
var is_add_to_favorites_supported : get = _is_add_to_favorites_supported_getter
var is_add_to_home_screen_supported : get = _is_add_to_home_screen_supported_getter
var is_rate_supported : get = _is_rate_supported_getter
var is_post_reward_supported : get = _is_post_reward_supported_getter


func _is_share_supported_getter():
	return _js_social.isShareSupported

func _is_join_community_supported_getter():
	return _js_social.isJoinCommunitySupported

func _is_invite_friends_supported_getter():
	return _js_social.isInviteFriendsSupported

func _is_create_post_supported_getter():
	return _js_social.isCreatePostSupported

func _is_add_to_favorites_supported_getter():
	return _js_social.isAddToFavoritesSupported

func _is_add_to_home_screen_supported_getter():
	return _js_social.isAddToHomeScreenSupported

func _is_rate_supported_getter():
	return _js_social.isRateSupported

func _is_post_reward_supported_getter():
	return _js_social.isPostRewardSupported
	
var _js_social = null
var _share_callback = null
var _js_share_then = JavaScriptBridge.create_callback(self._on_js_share_then)
var _js_share_catch = JavaScriptBridge.create_callback(self._on_js_share_catch)
var _join_community_callback = null
var _js_join_community_then = JavaScriptBridge.create_callback(self._on_js_join_community_then)
var _js_join_community_catch = JavaScriptBridge.create_callback(self._on_js_join_community_catch)
var _invite_friends_callback = null
var _js_invite_friends_then = JavaScriptBridge.create_callback(self._on_js_invite_friends_then)
var _js_invite_friends_catch = JavaScriptBridge.create_callback(self._on_js_invite_friends_catch)
var _create_post_callback = null
var _js_create_post_then = JavaScriptBridge.create_callback(self._on_js_create_post_then)
var _js_create_post_catch = JavaScriptBridge.create_callback(self._on_js_create_post_catch)
var _add_to_favorites_callback = null
var _js_add_to_favorites_then = JavaScriptBridge.create_callback(self._on_js_add_to_favorites_then)
var _js_add_to_favorites_catch = JavaScriptBridge.create_callback(self._on_js_add_to_favorites_catch)
var _add_to_home_screen_callback = null
var _js_add_to_home_screen_then = JavaScriptBridge.create_callback(self._on_js_add_to_home_screen_then)
var _js_add_to_home_screen_catch = JavaScriptBridge.create_callback(self._on_js_add_to_home_screen_catch)
var _rate_callback = null
var _js_rate_then = JavaScriptBridge.create_callback(self._on_js_rate_then)
var _js_rate_catch = JavaScriptBridge.create_callback(self._on_js_rate_catch)
var _get_post_reward_callback = null
var _js_get_post_reward_then = JavaScriptBridge.create_callback(self._on_js_get_post_reward_then)
var _js_get_post_reward_catch = JavaScriptBridge.create_callback(self._on_js_get_post_reward_catch)
var _utils = load("res://addons/playgama_bridge/utils.gd").new()


# share, invite_friends and create_post take either the id of an entry declared in
# playgama-bridge-config.json (social.shares, social.invites, social.posts) or a
# Dictionary with the content.
func share(options = null, callback = null):
	if _share_callback != null:
		return
	
	_share_callback = callback
	
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)
	
	_js_social.share(js_options).then(_js_share_then).catch(_js_share_catch)

func join_community(options = null, callback = null):
	if _join_community_callback != null:
		return
	
	_join_community_callback = callback
	
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)
	
	_js_social.joinCommunity(js_options).then(_js_join_community_then).catch(_js_join_community_catch)

func invite_friends(options = null, callback = null):
	if _invite_friends_callback != null:
		return

	_invite_friends_callback = callback
	
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)
		
	_js_social.inviteFriends(js_options).then(_js_invite_friends_then).catch(_js_invite_friends_catch)

# `payload` is the game's own string for this one post — a level, a seed, a
# challenge — handed back as Bridge.platform.payload when someone opens it.
# create_post(options, callback) from before the payload argument still works.
func create_post(options = null, payload = null, callback = null):
	if payload != null and typeof(payload) != TYPE_STRING:
		callback = payload
		payload = null
	
	if _create_post_callback != null:
		return
	
	_create_post_callback = callback
	
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)
	
	var promise = _js_social.createPost(js_options, payload) if payload != null else _js_social.createPost(js_options)
	promise.then(_js_create_post_then).catch(_js_create_post_catch)

func add_to_favorites(callback = null):
	if _add_to_favorites_callback != null:
		return

	_add_to_favorites_callback = callback
	_js_social.addToFavorites().then(_js_add_to_favorites_then).catch(_js_add_to_favorites_catch)

func add_to_home_screen(callback = null):
	if _add_to_home_screen_callback != null:
		return

	_add_to_home_screen_callback = callback
	_js_social.addToHomeScreen().then(_js_add_to_home_screen_then).catch(_js_add_to_home_screen_catch)

func rate(callback = null):
	if _rate_callback != null:
		return

	_rate_callback = callback
	_js_social.rate().then(_js_rate_then).catch(_js_rate_catch)

# Everything the player has coming from posts right now: the reward for the post the
# game was opened from and what the author earned from the players who came through
# their posts. The callback gets (success, rewards); the Array is empty when there is nothing.
func get_post_reward(callback = null):
	if _get_post_reward_callback != null:
		return

	_get_post_reward_callback = callback
	_js_social.getPostReward().then(_js_get_post_reward_then).catch(_js_get_post_reward_catch)


func _init(js_social):
	_js_social = js_social

func _on_js_share_then(args):
	if _share_callback != null:
		_share_callback.call(true)
		_share_callback = null

func _on_js_share_catch(args):
	if _share_callback != null:
		_share_callback.call(false)
		_share_callback = null

func _on_js_join_community_then(args):
	if _join_community_callback != null:
		_join_community_callback.call(true)
		_join_community_callback = null

func _on_js_join_community_catch(args):
	if _join_community_callback != null:
		_join_community_callback.call(false)
		_join_community_callback = null

func _on_js_invite_friends_then(args):
	if _invite_friends_callback != null:
		_invite_friends_callback.call(true)
		_invite_friends_callback = null

func _on_js_invite_friends_catch(args):
	if _invite_friends_callback != null:
		_invite_friends_callback.call(false)
		_invite_friends_callback = null

func _on_js_create_post_then(args):
	if _create_post_callback != null:
		_create_post_callback.call(true)
		_create_post_callback = null

func _on_js_create_post_catch(args):
	if _create_post_callback != null:
		_create_post_callback.call(false)
		_create_post_callback = null

func _on_js_add_to_favorites_then(args):
	if _add_to_favorites_callback != null:
		_add_to_favorites_callback.call(true)
		_add_to_favorites_callback = null

func _on_js_add_to_favorites_catch(args):
	if _add_to_favorites_callback != null:
		_add_to_favorites_callback.call(false)
		_add_to_favorites_callback = null

func _on_js_add_to_home_screen_then(args):
	if _add_to_home_screen_callback != null:
		_add_to_home_screen_callback.call(true)
		_add_to_home_screen_callback = null

func _on_js_add_to_home_screen_catch(args):
	if _add_to_home_screen_callback != null:
		_add_to_home_screen_callback.call(false)
		_add_to_home_screen_callback = null

func _on_js_rate_then(args):
	if _rate_callback != null:
		_rate_callback.call(true)
		_rate_callback = null

func _on_js_rate_catch(args):
	if _rate_callback != null:
		_rate_callback.call(false)
		_rate_callback = null

func _on_js_get_post_reward_then(args):
	if _get_post_reward_callback != null:
		var data = args[0]
		var data_type = typeof(data)
		match data_type:
			TYPE_OBJECT:
				var array = []
				for i in range(data.length):
					var item = _utils.convert_to_gd_object(data[i])
					array.append(item)
				_get_post_reward_callback.call(true, array)
			_:
				_get_post_reward_callback.call(false, [])
		_get_post_reward_callback = null

func _on_js_get_post_reward_catch(args):
	if _get_post_reward_callback != null:
		_get_post_reward_callback.call(false, [])
		_get_post_reward_callback = null
