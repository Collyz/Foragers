extends Control

@onready var settings_menu = preload("res://settings_menu.tscn").instantiate()
@onready var back_button = $BackButton

func _ready():
	pass
	
func _input(event):
	if Input.is_action_just_pressed("settings_hotkey"):
		var hasControlNode = get_node_or_null("SettingsControl")
		if hasControlNode == null:
			add_child(settings_menu)
		else:
			if settings_menu.get_node_or_null("QuitConfirmationControl"):
				settings_menu.remove_quit_confirmation()
			else:
				remove_child(settings_menu)
	
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
