@tool
extends EditorPlugin

const SINGLETON_NAME = "Bridge"
const SINGLETON_PATH = "res://addons/playgama_bridge/bridge.gd"
const POSTPROCESSOR_PLUGIN_PATH = "res://addons/playgama_bridge/postprocessor.gd"

func _enter_tree():
	add_autoload_singleton(SINGLETON_NAME, SINGLETON_PATH)
	add_export_plugin(load(POSTPROCESSOR_PLUGIN_PATH).new())

func _exit_tree():
	remove_autoload_singleton(SINGLETON_NAME)
