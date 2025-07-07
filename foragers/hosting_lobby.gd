extends Control

@onready var back_button = $BackButton

func _ready():
	pass


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
