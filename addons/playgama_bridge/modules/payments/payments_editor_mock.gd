var is_supported : get = _is_supported_getter
var is_get_catalog_supported : get = _is_get_catalog_supported_getter
var is_get_purchases_supported : get = _is_get_purchases_supported_getter
var is_consume_purchase_supported : get = _is_consume_purchase_supported_getter

func _is_supported_getter():
	return false

func _is_get_catalog_supported_getter():
	return false

func _is_get_purchases_supported_getter():
	return false
	
func _is_consume_purchase_supported_getter():
	return false


func purchase(options = null, callback = null):
	if callback != null:
		callback.call(false)

func consume_purchase(options = null, callback = null):
	if callback != null:
		callback.call(false)

func get_catalog(callback = null):
	if callback != null:
		callback.call(false, [])

func get_purchases(callback = null):
	if callback != null:
		callback.call(false, [])
