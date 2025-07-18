signal banner_state_changed
signal interstitial_state_changed
signal rewarded_state_changed

var minimum_delay_between_interstitial : get = _minimum_delay_between_interstitial_getter
var is_banner_supported : get = _is_banner_supported_getter
var banner_state : get = _banner_state_getter
var is_interstitial_supported : get = _is_interstitial_supported_getter
var interstitial_state : get = _interstitial_state_getter
var is_rewarded_supported : get = _is_rewarded_supported_getter
var rewarded_state : get = _rewarded_state_getter
var rewarded_placement : get = _rewarded_placement_getter


func _minimum_delay_between_interstitial_getter():
	return _js_advertisement.minimumDelayBetweenInterstitial

func _is_banner_supported_getter():
	return _js_advertisement.isBannerSupported

func _banner_state_getter():
	return _js_advertisement.bannerState

func _is_interstitial_supported_getter():
	return _js_advertisement.isInterstitialSupported

func _interstitial_state_getter():
	return _js_advertisement.interstitialState

func _is_rewarded_supported_getter():
	return _js_advertisement.isRewardedSupported

func _rewarded_state_getter():
	return _js_advertisement.rewardedState

func _rewarded_placement_getter():
	return _js_advertisement.rewardedPlacement

var _js_advertisement = null
var _js_on_banner_state_changed = JavaScriptBridge.create_callback(self._on_banner_state_changed)
var _js_on_interstitial_state_changed = JavaScriptBridge.create_callback(self._on_interstitial_state_changed)
var _js_on_rewarded_state_changed = JavaScriptBridge.create_callback(self._on_rewarded_state_changed)
var _utils = load("res://addons/playgama_bridge/utils.gd").new()
var _check_adblock_callback = null
var _js_check_adblock_then = JavaScriptBridge.create_callback(self._on_js_check_adblock_then)
var _js_check_adblock_catch = JavaScriptBridge.create_callback(self._on_js_check_adblock_catch)


func set_minimum_delay_between_interstitial(value):
	_js_advertisement.setMinimumDelayBetweenInterstitial(value)

func show_banner(position = Bridge.BannerPosition.BOTTOM, placement = null):
	_js_advertisement.showBanner(position, placement)

func hide_banner():
	_js_advertisement.hideBanner()

func show_interstitial(placement = null):
	_js_advertisement.showInterstitial(placement)

func show_rewarded(placement = null):
	_js_advertisement.showRewarded(placement)

func check_adblock(callback):
	if _check_adblock_callback != null:
		return
	
	_check_adblock_callback = callback
	_js_advertisement.checkAdBlock().then(_js_check_adblock_then).catch(_js_check_adblock_catch)


func _init(js_advertisement):
	_js_advertisement = js_advertisement
	_js_advertisement.on('banner_state_changed', _js_on_banner_state_changed)
	_js_advertisement.on('interstitial_state_changed', _js_on_interstitial_state_changed)
	_js_advertisement.on('rewarded_state_changed', _js_on_rewarded_state_changed)

func _on_banner_state_changed(args):
	emit_signal("banner_state_changed", args[0])

func _on_interstitial_state_changed(args):
	emit_signal("interstitial_state_changed", args[0])

func _on_rewarded_state_changed(args):
	emit_signal("rewarded_state_changed", args[0])

func _on_js_check_adblock_then(args):
	if _check_adblock_callback != null:
		var data = args[0]
		var data_type = typeof(data)
		match data_type:
			TYPE_BOOL:
				_check_adblock_callback.call(data)
			_:
				_check_adblock_callback.call(false)
		_check_adblock_callback = null

func _on_js_check_adblock_catch(args):
	if _check_adblock_callback != null:
		_check_adblock_callback.call(false)
		_check_adblock_callback = null
