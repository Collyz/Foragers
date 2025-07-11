extends Control
@onready var settings_menu = preload("res://setting_interface_scenes/settings_menu.tscn").instantiate()
var screen_size = Vector2(0, 0)

func _ready():
	screen_size = get_viewport().get_visible_rect().size

func _input(event):
	if Input.is_action_just_pressed("settings_hotkey"):
		_on_settings_button_pressed()


func _on_settings_button_pressed():
	var parent_node = get_parent()
	var hasControlNode = parent_node.get_node_or_null("SettingsControl")
	if hasControlNode == null: # Adding the settings menu to the parent
		get_parent().add_child(settings_menu)
		settings_menu.position = Vector2(screen_size.x/2, screen_size.y/2)
	else:
		# Checking to see if the quit confirmation is up and add/removing it
		if settings_menu.get_node_or_null("QuitConfirmationControl"):
			settings_menu.remove_quit_confirmation()
		else:
			parent_node.remove_child(settings_menu)
