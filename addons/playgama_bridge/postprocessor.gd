extends EditorExportPlugin

const INDEX_FILE_NAME = "index.html"
const TMP_JS_EXPORT_INDEX_FILE_NAME = "tmp_js_export.html"
const JS_SDK_FILE_NAME = "playgama-bridge.js"
const JS_SDK_CONFIG_FILE_NAME = "playgama-bridge-config.json"
const JS_SDK_PATH = "res://addons/playgama_bridge/template/"


var _path = null

func _get_name() -> String:
	return "Bridge"

func _export_begin(features, is_debug, path, flags):
	if features.has("web"):
		_path = path
		
		_copy_file(JS_SDK_FILE_NAME)
		_copy_file(JS_SDK_CONFIG_FILE_NAME)

func _copy_file(file_name):
	var file_from = FileAccess.open(JS_SDK_PATH + file_name, FileAccess.READ)
	var file_to = FileAccess.open(_path.get_base_dir() + "/" + file_name, FileAccess.WRITE)
	file_to.store_string(file_from.get_as_text())
	
	file_from = null
	file_to = null
