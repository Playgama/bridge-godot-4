extends DetailedSceneBase

@onready var is_banner_supported_label = $MarginContainer2/HBoxContainer/VBoxContainer/IsBannerSupported
@onready var banner_state_label = $MarginContainer2/HBoxContainer/VBoxContainer/BannerState
@onready var minimum_delay_label = $MarginContainer2/HBoxContainer/VBoxContainer/MinimumDelay
@onready var interstitial_state_label = $MarginContainer2/HBoxContainer/VBoxContainer/InterstitialState
@onready var rewarded_state_label = $MarginContainer2/HBoxContainer/VBoxContainer/RewardedState
@onready var rewarded_placement_label = $MarginContainer2/HBoxContainer/VBoxContainer/RewardedPlacement
@onready var adblock_detected_label = $MarginContainer2/HBoxContainer/VBoxContainer2/AdBlockDetected

var last_banner_states = []
var last_interstitial_states = []
var last_rewarded_states = []


func _ready():
	is_banner_supported_label.text = "Is Banner Supported: " + str(Bridge.advertisement.is_banner_supported)
	minimum_delay_label.text = "Minimum Delay Between Interstitial: " + str(Bridge.advertisement.minimum_delay_between_interstitial)
	
	_on_banner_state_changed(Bridge.advertisement.banner_state)
	_on_interstitial_state_changed(Bridge.advertisement.interstitial_state)
	_on_rewarded_state_changed(Bridge.advertisement.rewarded_state)
	
	Bridge.advertisement.connect("banner_state_changed", Callable(self, "_on_banner_state_changed"))
	Bridge.advertisement.connect("interstitial_state_changed", Callable(self, "_on_interstitial_state_changed"))
	Bridge.advertisement.connect("rewarded_state_changed", Callable(self, "_on_rewarded_state_changed"))


func _on_show_banner_button_pressed():
	Bridge.advertisement.show_banner(Bridge.BannerPosition.BOTTOM)

func _on_hide_banner_button_pressed():
	Bridge.advertisement.hide_banner()

func _on_show_interstitial_button_pressed():
	Bridge.advertisement.show_interstitial()

func _on_show_rewarded_button_pressed():
	Bridge.advertisement.show_rewarded()

func _on_check_adblock_button_pressed():
	Bridge.advertisement.check_adblock(Callable(self, "_on_check_adblock_completed"))


func _on_banner_state_changed(state):
	if state == null:
		return
	
	last_banner_states.append(state)
	
	if last_banner_states.size() > 5:
		last_banner_states.remove(0)
	
	_update_banner_states()

func _on_interstitial_state_changed(state):
	if state == null:
		return
	
	last_interstitial_states.append(state)
	
	if last_interstitial_states.size() > 5:
		last_interstitial_states.remove(0)
	
	_update_interstitial_states()

func _on_rewarded_state_changed(state):
	if state == null:
		return
	
	last_rewarded_states.append(state)
	
	if last_rewarded_states.size() > 5:
		last_rewarded_states.remove(0)
	
	_update_rewarded_placement()
	_update_rewarded_states()

func _on_check_adblock_completed(result):
	adblock_detected_label.text = "AdBlock Detected: " + str(result)


func _update_banner_states():
	var text = "Last Banner States: "
	
	for state in last_banner_states:
		text += state + " -> "
	
	banner_state_label.text = text

func _update_interstitial_states():
	var text = "Last Interstitial States: "
	
	for state in last_interstitial_states:
		text += state + " -> "
	
	interstitial_state_label.text = text

func _update_rewarded_states():
	var text = "Last Rewarded States: "
	
	for state in last_rewarded_states:
		text += state + " -> "
	
	rewarded_state_label.text = text

func _update_rewarded_placement():
	rewarded_placement_label.text = "Rewarded Placement: " + str(Bridge.advertisement.rewarded_placement)
