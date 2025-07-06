extends Control

@onready var host_button = $VBoxContainer/HBoxContainer/HostGameButton
@onready var join_button = $VBoxContainer/HBoxContainer/JoinGameButton

func _ready():
	pass

func _on_join_game_button_pressed():
	print("Join game selected")


func _on_host_game_button_pressed():
	print("Host game selected")
