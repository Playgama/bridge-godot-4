func convert_to_js(data):
	var data_type = typeof(data)
	
	match data_type:
		TYPE_DICTIONARY:
			var js_object = JavaScriptBridge.create_object("Object")
			
			for key in data:
				js_object[key] = convert_to_js(data[key])
			
			return js_object
		
		TYPE_ARRAY:
			var js_array = JavaScriptBridge.create_object("Array")
			
			for i in range(data.size()):
				js_array[i] = convert_to_js(data[i])
			
			return js_array
		
		TYPE_STRING:
			return data
		
		TYPE_BOOL:
			return data
		
		TYPE_INT:
			return data
		
		TYPE_FLOAT:
			return data
	
	return null

func serialize_value(value):
	var value_type = typeof(value)

	if value_type == TYPE_DICTIONARY or value_type == TYPE_ARRAY:
		return JSON.stringify(value)

	return value

func deserialize_value(value):
	if typeof(value) != TYPE_STRING:
		return value

	if value == "true":
		return true

	if value == "false":
		return false

	# Structured data goes through the JSON parser. The prefix check also keeps the parser
	# from logging an error for every plain value
	if value.begins_with("{") or value.begins_with("["):
		var json = JSON.new()
		if json.parse(value) != OK:
			return value

		var parsed_type = typeof(json.data)
		if parsed_type == TYPE_DICTIONARY or parsed_type == TYPE_ARRAY:
			return json.data

		return value

	# Numbers are restored only when the text survives the conversion unchanged, so values
	# like "007" or "1.10" keep the exact form they were stored in. The length check keeps
	# oversized values away from the 64-bit conversion, which logs an error on overflow
	if value.length() < 19 and value.is_valid_int() and str(int(value)) == value:
		return int(value)

	if value.is_valid_float() and str(float(value)) == value:
		return float(value)

	return value

func convert_to_gd_object(js_data):
	if typeof(js_data) != TYPE_OBJECT:
		return null
	
	var js_item_keys = JavaScriptBridge.get_interface("Object").keys(js_data)
	var item = {}
	for j in range(js_item_keys.length):
		var key = js_item_keys[j]
		item[key] = js_data[key]

	return item
