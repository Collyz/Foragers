extends Control

@onready var quit_button = $QuitButton
@onready var resume_button = $ResumeButton

@onready var quit_confirmation = preload("res://setting_interface_scenes/quit_confirmation_control.tscn").instantiate()


func _on_resume_button_pressed():
	get_parent().remove_child(self)

func _on_quit_button_pressed():
	add_child(quit_confirmation)

func remove_quit_confirmation():
	remove_child(quit_confirmation)

func quit_game_confirmed():
	get_tree().quit()
