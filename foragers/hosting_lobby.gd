extends Control

@onready var settings_menu = preload("res://settings_menu.tscn").instantiate()
@onready var back_button = $BackButton

func _ready():
	pass


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_start_button_pressed():
	print("Start button pressed")
	get_tree().change_scene_to_file("res://game_scene.tscn")
