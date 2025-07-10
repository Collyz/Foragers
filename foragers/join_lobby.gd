extends Control

@onready var settings_menu = preload("res://settings_menu.tscn").instantiate()
@onready var back_button = $BackButton

func _ready():
	pass
	
func _input(event):
	pass
	
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
