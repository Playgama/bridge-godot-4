extends DetailedSceneBase


@onready var is_payments_supported_label = $MarginContainer2/VBoxContainer/IsPaymentsSupported
@onready var is_get_catalog_supported_label = $MarginContainer2/VBoxContainer/IsGetCatalogSupported
@onready var is_get_purchases_supported_label = $MarginContainer2/VBoxContainer/IsGetPurchasesSupported
@onready var is_consume_purchase_supported_label = $MarginContainer2/VBoxContainer/IsConsumePurchaseSupported


func _ready():
	is_payments_supported_label.text = "Is Payments Supported: " + str(Bridge.payments.is_supported)
	is_get_catalog_supported_label.text = "Is Get Catalog Supported: " + str(Bridge.payments.is_get_catalog_supported)
	is_get_purchases_supported_label.text = "Is Get Purchases Supported: " + str(Bridge.payments.is_get_purchases_supported)
	is_consume_purchase_supported_label.text = "Is Consume Purchase Supported: " + str(Bridge.payments.is_consume_purchase_supported)


func _on_purchase_button_pressed():
	var options
	
	match Bridge.platform.id:
		"yandex":
			options = {
				"id": "PRODUCT_ID"
			}
	
	Bridge.payments.purchase(options, Callable(self, "_on_purchase_completed"))
	
func _on_purchase_completed(success, purchase):
	print(success)
	
	if purchase != null:
		match Bridge.platform.id:
			"yandex":
				print("Product ID: " + str(purchase.productID))
				print("Purchase Token: " + str(purchase.purchaseToken))
			"facebook":
				print("Product ID: " + str(purchase.productID))
				print("Purchase Token: " + str(purchase.purchaseToken))


func _on_consume_button_pressed():
	var options
	
	match Bridge.platform.id:
		"yandex":
			options = {
				"purchaseToken": "PURCHASE_TOKEN"
			}

	Bridge.payments.consume_purchase(options, Callable(self, "_on_consume_completed"))
	
func _on_consume_completed(success):
	print(success)


func _on_get_catalog_button_pressed():
	Bridge.payments.get_catalog(Callable(self, "_on_get_catalog_completed"))
	
func _on_get_catalog_completed(success, catalog):
	print(success)

	match Bridge.platform.id:
		"yandex":
			for item in catalog:
				print("ID: " + str(item.id))
				print("Title: " + str(item.title))
				print("Description: " + str(item.description))
				print("Image: " + str(item.imageURI))
				print("Price: " + str(item.price))
				print("Price Currency Code: " + str(item.priceCurrencyCode))
				print("Price Currency Image: " + str(item.priceCurrencyImage))
				print("Price Value: " + str(item.priceValue))


func _on_get_purchases_button_pressed():
	Bridge.payments.get_purchases(Callable(self, "_on_get_purchases_completed"))
	
func _on_get_purchases_completed(success, purchases):
	print(success)

	match Bridge.platform.id:
		"yandex":
			for purchase in purchases:
				print("Developer Payload: " + str(purchase.developerPayload))
				print("Product Id: " + str(purchase.productID))
				print("Purchase Token: " + str(purchase.purchaseToken))
