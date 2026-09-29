extends DetailedSceneBase

@onready var is_share_supported = $MarginContainer2/VBoxContainer/HBoxContainer2/VBoxContainer/IsShareSupported
@onready var is_join_community_supported = $MarginContainer2/VBoxContainer/HBoxContainer2/VBoxContainer/IsJoinCommunitySupported
@onready var is_invite_friends_supported = $MarginContainer2/VBoxContainer/HBoxContainer2/VBoxContainer/IsInviteFriendsSupported
@onready var is_create_post_supported = $MarginContainer2/VBoxContainer/HBoxContainer2/VBoxContainer/IsCreatePostSupported
@onready var is_add_to_favorites_supported = $MarginContainer2/VBoxContainer/HBoxContainer2/VBoxContainer2/IsAddToFavoritesSupported2
@onready var is_add_to_home_screen_supported = $MarginContainer2/VBoxContainer/HBoxContainer2/VBoxContainer2/IsAddToHomeScreenSupported
@onready var is_rate_supported = $MarginContainer2/VBoxContainer/HBoxContainer2/VBoxContainer2/IsRateSupported
@onready var is_external_links_allowed = $MarginContainer2/VBoxContainer/HBoxContainer2/VBoxContainer2/IsExternalLinksAllowed



func _ready():
	is_share_supported.text = "Is Share Supported: " + str(Bridge.social.is_share_supported)
	is_join_community_supported.text = "Is Join Community Supported: " + str(Bridge.social.is_join_community_supported)
	is_invite_friends_supported.text = "Is Invite Friends Supported: " + str(Bridge.social.is_invite_friends_supported)
	is_create_post_supported.text = "Is Create Post Supported: " + str(Bridge.social.is_create_post_supported)
	is_add_to_favorites_supported.text = "Is Add To Favorites Supported: " + str(Bridge.social.is_add_to_favorites_supported)
	is_add_to_home_screen_supported.text = "Is Add To Home Screen Supported: " + str(Bridge.social.is_add_to_home_screen_supported)
	is_rate_supported.text = "Is Rate Supported: " + str(Bridge.social.is_rate_supported)
	is_external_links_allowed.text = "Is External Links Allowed: " + str(Bridge.platform.is_external_links_allowed)

	# Grant whatever the posts brought: the reward of the post the game was opened
	# from and what the player's own posts earned since the previous check.
	if Bridge.social.is_post_reward_supported:
		Bridge.social.get_post_reward(Callable(self, "_on_get_post_reward_completed"))


func _on_get_post_reward_completed(success, rewards):
	print(success)

	for reward in rewards:
		print(reward.type + ": " + str(reward.amount) + " " + reward.id)


func _on_share_button_pressed():
	# "score" is the id of an entry declared in "social.shares" of playgama-bridge-config.json
	Bridge.social.share("score")


func _on_create_post_button_pressed():
	# "gift" is the id of an entry declared in "social.posts" of playgama-bridge-config.json.
	# A second string travels with the post and comes back as Bridge.platform.payload
	# when someone opens it: Bridge.social.create_post("level", level_json)
	Bridge.social.create_post("gift")


func _on_join_community_button_pressed():
	# The community ("groupId" and so on) is declared in "social.joinCommunity"
	# of playgama-bridge-config.json
	Bridge.social.join_community()


func _on_invite_friends_button_pressed():
	# "friends" is the id of an entry declared in "social.invites" of playgama-bridge-config.json
	Bridge.social.invite_friends("friends")


func _on_add_to_favorites_button_pressed():
	Bridge.social.add_to_favorites()


func _on_add_to_home_screen_button_pressed():
	Bridge.social.add_to_home_screen()


func _on_rate_button_pressed():
	Bridge.social.rate()
