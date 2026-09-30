@tool
extends EditorPlugin

const SINGLETON_NAME = "Bridge"
const SINGLETON_PATH = "res://addons/playgama_bridge/bridge.gd"
const POSTPROCESSOR_PLUGIN_PATH = "res://addons/playgama_bridge/postprocessor.gd"

var _export_plugin = null

func _enter_tree():
	add_autoload_singleton(SINGLETON_NAME, SINGLETON_PATH)
	_export_plugin = load(POSTPROCESSOR_PLUGIN_PATH).new()
	add_export_plugin(_export_plugin)

func _exit_tree():
	remove_autoload_singleton(SINGLETON_NAME)
	if _export_plugin != null:
		remove_export_plugin(_export_plugin)
		_export_plugin = null
