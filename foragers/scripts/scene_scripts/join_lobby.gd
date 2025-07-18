extends Control
class_name ClientScreen

var parent: SceneControllerNode
@onready var error_label = $VBoxContainer/ErrorLabel
@onready var lobby_code_edit = $VBoxContainer/LobbyCodeHBox/LobbyCodeEdit
@onready var username_edit = $VBoxContainer/UsernameHBox/UsernameEdit

var username: String = ""
var valid_code = false

func _ready():
	parent = get_parent()
	clear_error_label()
	
func _input(_event):
	pass
	
func clear_lobby_line_edit() -> void:
	lobby_code_edit.clear()
	
func clear_name_line_edit() -> void:
	username_edit.clear()
	
func clear_error_label() -> void:
	error_label.text = ""
	
func set_error_label(msg_to_user: String, color: Color) -> void:
	error_label.add_theme_color_override("font_color", color)
	error_label.text = msg_to_user
	
func join_lobby(lobby_code: String):
	print("Client input code: ", lobby_code)
	await parent.join_game()
	parent.remove_child(self)


func _on_username_edit_text_submitted(new_text) -> void:
	if len(new_text) < 2:
		set_error_label("Username must be greater than 2 characters", Color.RED)
	else:
		username = new_text
		set_error_label("Username: %s" % username, Color.GREEN)
	clear_error_label()

func _on_username_edit_text_changed(_new_text) -> void:
	clear_error_label()

func _on_join_game_button_pressed() -> void:
	var input_lobby_code = lobby_code_edit.text
	join_lobby(input_lobby_code)
	

func _on_lobby_code_edit_text_submitted(new_text):
	join_lobby(new_text)


func _on_lobby_code_edit_text_changed(_new_text):
	clear_error_label()
	
func _on_back_button_pressed() -> void:
	parent.remove_child(self)
	parent.scene_to_menu()
