extends Control

@onready var host_button = $VBoxContainer/HBoxContainer/HostGameButton
@onready var join_button = $VBoxContainer/HBoxContainer/JoinGameButton

func _ready():
	pass

func _on_join_game_button_pressed():
	get_tree().change_scene_to_file("res://join_lobby.tscn")


func _on_host_game_button_pressed():
	get_tree().change_scene_to_file("res://hosting_lobby.tscn")
	#print("Host game selected")
