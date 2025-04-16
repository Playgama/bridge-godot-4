extends DetailedSceneBase


@onready var is_payments_supported_label = $MarginContainer2/VBoxContainer/IsPaymentsSupported


func _ready():
	is_payments_supported_label.text = "Is Payments Supported: " + str(Bridge.payments.is_supported)


func _on_purchase_button_pressed():
	Bridge.payments.purchase("test_product", Callable(self, "_on_purchase_completed"))
	
func _on_purchase_completed(success, purchase):
	print(success)


func _on_consume_button_pressed():
	Bridge.payments.consume_purchase("test_product", Callable(self, "_on_consume_completed"))
	
func _on_consume_completed(success):
	print(success)


func _on_get_catalog_button_pressed():
	Bridge.payments.get_catalog(Callable(self, "_on_get_catalog_completed"))
	
func _on_get_catalog_completed(success, catalog):
	print(success)

	for item in catalog:
		print("Common ID: " + str(item.commonId))
		print("Price: " + str(item.price))
		print("Price Currency Code: " + str(item.priceCurrencyCode))
		print("Price Value: " + str(item.priceValue))


func _on_get_purchases_button_pressed():
	Bridge.payments.get_purchases(Callable(self, "_on_get_purchases_completed"))
	
func _on_get_purchases_completed(success, purchases):
	print(success)

	for purchase in purchases:
		print("Common Id: " + str(purchase.commonId))
