extends Control

@onready var back_btn = $BackButton
@onready var lobby_code_btn = $LobbyLabel/LobbyCodeButton
var parent: SceneControllerNode = null

func _ready():
	parent = get_parent()

func _input(event):
	pass

func _on_back_button_pressed():
	parent.remove_child(self)
	parent.scene_to_menu()


func _on_start_button_pressed():
	parent.remove_child(self)
	parent.scene_to_game()


func _on_lobby_code_button_pressed():
	var button_text = lobby_code_btn.text
	DisplayServer.clipboard_set(button_text)
