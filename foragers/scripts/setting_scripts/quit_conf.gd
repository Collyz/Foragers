extends Control


func _on_no_button_pressed():
	get_parent().remove_quit_confirmation()


func _on_yes_button_pressed():
	get_parent().quit_game_confirmed()
