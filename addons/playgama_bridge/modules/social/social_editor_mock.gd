var is_share_supported : get = _is_share_supported_getter
var is_join_community_supported : get = _is_join_community_supported_getter
var is_invite_friends_supported : get = _is_invite_friends_supported_getter
var is_create_post_supported : get = _is_create_post_supported_getter
var is_add_to_favorites_supported : get = _is_add_to_favorites_supported_getter
var is_add_to_home_screen_supported : get = _is_add_to_home_screen_supported_getter
var is_rate_supported : get = _is_rate_supported_getter


func _is_share_supported_getter():
	return false

func _is_join_community_supported_getter():
	return false

func _is_invite_friends_supported_getter():
	return false

func _is_create_post_supported_getter():
	return false

func _is_add_to_favorites_supported_getter():
	return false

func _is_add_to_home_screen_supported_getter():
	return false

func _is_rate_supported_getter():
	return false


func share(options = null, callback = null):
	if callback != null:
		callback.call(false)

func join_community(options = null, callback = null):
	if callback != null:
		callback.call(false)

func invite_friends(options = null, callback = null):
	if callback != null:
		callback.call(false)

func create_post(options = null, callback = null):
	if callback != null:
		callback.call(false)

func add_to_favorites(callback = null):
	if callback != null:
		callback.call(false)

func add_to_home_screen(callback = null):
	if callback != null:
		callback.call(false)

func rate(callback = null):
	if callback != null:
		callback.call(false)
