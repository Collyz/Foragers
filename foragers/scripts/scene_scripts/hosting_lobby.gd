extends Control
class_name HostingScreen

@onready var lobby_code_btn = $VBoxContainer/LobbyCodeHBox/LobbyCodeButton
var parent: SceneControllerNode = null
var lobby_code: String = ""

func _ready():
	parent = get_parent()

func _input(_event):
	pass

func set_lobby_code(generated_code: String):
	lobby_code_btn.text = generated_code + " ⧉"
	lobby_code = generated_code

func _on_back_button_pressed():
	parent.remove_child(self)
	parent.scene_to_menu()

func _on_start_button_pressed():
	parent.remove_child(self)
	parent.scene_to_game()

func _on_lobby_code_button_pressed():
	DisplayServer.clipboard_set(lobby_code)
