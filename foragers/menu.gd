extends Control

@onready var settings_menu = preload("res://settings_menu.tscn").instantiate()

@onready var host_button = $VBoxContainer/HBoxContainer/HostGameButton
@onready var join_button = $VBoxContainer/HBoxContainer/JoinGameButton



func _ready():
	pass

func _input(event):
	if Input.is_action_just_pressed("settings_hotkey"):
		var hasControlNode = get_node_or_null("SettingsControl")
		if hasControlNode == null:
			add_child(settings_menu)
		else:
			if settings_menu.get_node_or_null(	"QuitConfirmationControl"):
				settings_menu.remove_quit_confirmation()
			else:
				remove_child(settings_menu)
	pass

func _on_join_game_button_pressed():
	get_tree().change_scene_to_file("res://join_lobby.tscn")


func _on_host_game_button_pressed():
	get_tree().change_scene_to_file("res://hosting_lobby.tscn")
	#print("Host game selected")
