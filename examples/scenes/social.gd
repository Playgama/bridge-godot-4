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


func _on_share_button_pressed():
	# Pass canonical content fields ("text", "image", "url"); the bridge maps them to
	# each platform (e.g. VK uses "url" as the share link, Discord as the media url).
	# Platform-specific defaults can also be set in playgama-bridge-config.json under "social".
	Bridge.social.share({
		"text": "Check out this game!",
		"url": "YOUR_GAME_URL"
	})


func _on_create_post_button_pressed():
	# Canonical "text"/"url"; the bridge assembles the platform-native post (e.g. OK
	# builds its media attachment). "status" (publish to profile) can be set per-platform
	# in playgama-bridge-config.json under "social".
	Bridge.social.create_post({
		"text": "I'm playing this game!",
		"url": "YOUR_GAME_URL"
	})


func _on_join_community_button_pressed():
	# "groupId" is platform-specific; it can also be declared in playgama-bridge-config.json
	# under "social" instead of being passed at call time.
	var options

	match Bridge.platform.id:
		"vk":
			options = {
				"groupId": "199747461"
			}
		"ok":
			options = {
				"groupId": "62984239710374"
			}

	Bridge.social.join_community(options)


func _on_invite_friends_button_pressed():
	Bridge.social.invite_friends({
		"text": "Hello World!"
	})


func _on_add_to_favorites_button_pressed():
	Bridge.social.add_to_favorites()


func _on_add_to_home_screen_button_pressed():
	Bridge.social.add_to_home_screen()


func _on_rate_button_pressed():
	Bridge.social.rate()
