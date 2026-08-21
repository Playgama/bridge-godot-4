extends Node


const DeviceType = {
	DESKTOP = "desktop",
	MOBILE = "mobile",
	TABLET = "tablet",
	TV = "tv"
}

const PlatformMessage = {
	GAME_READY = "game_ready",
	IN_GAME_LOADING_STARTED = "in_game_loading_started",
	IN_GAME_LOADING_STOPPED = "in_game_loading_stopped",
	GAMEPLAY_STARTED = "gameplay_started",
	GAMEPLAY_STOPPED = "gameplay_stopped",
	PLAYER_GOT_ACHIEVEMENT = "player_got_achievement",
	LEVEL_STARTED = "level_started",
	LEVEL_COMPLETED = "level_completed",
	LEVEL_FAILED = "level_failed",
	LEVEL_PAUSED = "level_paused",
	LEVEL_RESUMED = "level_resumed"
}

const LeaderboardType = {
	NOT_AVAILABLE = "not_available",
	IN_GAME = "in_game",
	NATIVE = "native",
	NATIVE_POPUP = "native_popup"
}

const BannerPosition = {
	TOP = "top",
	BOTTOM = "bottom"
}

const BannerState = {
	LOADING = "loading",
	SHOWN = "shown",
	HIDDEN = "hidden",
	FAILED = "failed"
}

const InterstitialState = {
	LOADING = "loading",
	OPENED = "opened",
	CLOSED = "closed",
	FAILED = "failed"
}

const RewardedState = {
	LOADING = "loading",
	OPENED = "opened",
	REWARDED = "rewarded",
	CLOSED = "closed",
	FAILED = "failed"
}


var platform : get = _platform_getter
var device : get = _device_getter
var player : get = _player_getter
var storage : get = _storage_getter
var advertisement : get = _advertisement_getter
var social : get = _social_getter
var leaderboards : get = _leaderboards_getter
var payments : get = _payments_getter
var achievements : get = _achievements_getter
var remote_config : get = _remote_config_getter
var cross_promo : get = _cross_promo_getter
var tasks : get = _tasks_getter
var daily_rewards : get = _daily_rewards_getter
var notifications : get = _notifications_getter


func _platform_getter():
	return _platform

func _device_getter():
	return _device

func _player_getter():
	return _player

func _storage_getter():
	return _storage

func _advertisement_getter():
	return _advertisement

func _social_getter():
	return _social

func _leaderboards_getter():
	return _leaderboards

func _payments_getter():
	return _payments

func _achievements_getter():
	return _achievements


func _remote_config_getter():
	return _remote_config

func _cross_promo_getter():
	return _cross_promo

func _tasks_getter():
	return _tasks

func _daily_rewards_getter():
	return _daily_rewards

func _notifications_getter():
	return _notifications

var _platform = null
var _device = null
var _player = null
var _storage = null
var _advertisement = null
var _social = null
var _leaderboards = null
var _payments = null
var _achievements = null
var _remote_config = null
var _cross_promo = null
var _tasks = null
var _daily_rewards = null
var _notifications = null


func _ready():
	if OS.has_feature("web"):
		var js_bridge = JavaScriptBridge.get_interface("bridge")
		_platform = load("res://addons/playgama_bridge/modules/platform/platform.gd").new(js_bridge.platform)
		_device = load("res://addons/playgama_bridge/modules/device/device.gd").new(js_bridge.device)
		_player = load("res://addons/playgama_bridge/modules/player/player.gd").new(js_bridge.player)
		_storage = load("res://addons/playgama_bridge/modules/storage/storage.gd").new(js_bridge.storage)
		_advertisement = load("res://addons/playgama_bridge/modules/advertisement/advertisement.gd").new(js_bridge.advertisement)
		_social = load("res://addons/playgama_bridge/modules/social/social.gd").new(js_bridge.social)
		_leaderboards = load("res://addons/playgama_bridge/modules/leaderboards/leaderboards.gd").new(js_bridge.leaderboards)
		_payments = load("res://addons/playgama_bridge/modules/payments/payments.gd").new(js_bridge.payments)
		_achievements = load("res://addons/playgama_bridge/modules/achievements/achievements.gd").new(js_bridge.achievements)
		_remote_config = load("res://addons/playgama_bridge/modules/remote_config/remote_config.gd").new(js_bridge.remoteConfig)
		_cross_promo = load("res://addons/playgama_bridge/modules/cross_promo/cross_promo.gd").new(js_bridge.crossPromo)
		_tasks = load("res://addons/playgama_bridge/modules/tasks/tasks.gd").new(js_bridge.tasks)
		_daily_rewards = load("res://addons/playgama_bridge/modules/daily_rewards/daily_rewards.gd").new(js_bridge.dailyRewards)
		_notifications = load("res://addons/playgama_bridge/modules/notifications/notifications.gd").new(js_bridge.notifications)
	else:
		_platform = load("res://addons/playgama_bridge/modules/platform/platform_editor_mock.gd").new()
		_device = load("res://addons/playgama_bridge/modules/device/device_editor_mock.gd").new()
		_player = load("res://addons/playgama_bridge/modules/player/player_editor_mock.gd").new()
		_storage = load("res://addons/playgama_bridge/modules/storage/storage_editor_mock.gd").new()
		_advertisement = load("res://addons/playgama_bridge/modules/advertisement/advertisement_editor_mock.gd").new()
		_social = load("res://addons/playgama_bridge/modules/social/social_editor_mock.gd").new()
		_leaderboards = load("res://addons/playgama_bridge/modules/leaderboards/leaderboards_editor_mock.gd").new()
		_payments = load("res://addons/playgama_bridge/modules/payments/payments_editor_mock.gd").new()
		_achievements = load("res://addons/playgama_bridge/modules/achievements/achievements_editor_mock.gd").new()
		_remote_config = load("res://addons/playgama_bridge/modules/remote_config/remote_config_editor_mock.gd").new()
		_cross_promo = load("res://addons/playgama_bridge/modules/cross_promo/cross_promo_editor_mock.gd").new()
		_tasks = load("res://addons/playgama_bridge/modules/tasks/tasks_editor_mock.gd").new()
		_daily_rewards = load("res://addons/playgama_bridge/modules/daily_rewards/daily_rewards_editor_mock.gd").new()
		_notifications = load("res://addons/playgama_bridge/modules/notifications/notifications_editor_mock.gd").new()
