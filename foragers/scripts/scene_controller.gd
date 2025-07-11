extends Node
class_name SceneControllerNode

@onready var menu = preload("res://scenes/start_menu.tscn").instantiate()
@onready var joining_sccene = preload("res://scenes/join_lobby.tscn").instantiate()
@onready var hosting_scene = preload("res://scenes/hosting_lobby.tscn").instantiate()
@onready var game_scene = preload("res://scenes/game_scene.tscn").instantiate()

func _ready():
	add_child(menu)

func scene_to_menu():
	if get_node_or_null("res://scenes/start_menu.tscn") == null:
		add_child(menu)

func scene_to_joining():
	if get_node_or_null("res://scenes/join_lobby.tscn") == null:
		add_child(joining_sccene)
		
func scene_to_hosting():
	if get_node_or_null("res://scenes/hosting_lobby.tscn") == null:
		add_child(hosting_scene)

func scene_to_game():
	if get_node_or_null("res://scenes/game_scene.tscn") == null:
		add_child(game_scene)
