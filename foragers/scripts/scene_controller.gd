extends Node
class_name SceneControllerNode

@onready var menu = preload("res://scenes/start_menu.tscn").instantiate()
@onready var joining_scene: ClientScreen  = preload("res://scenes/join_lobby.tscn").instantiate()
@onready var hosting_scene: HostingScreen = preload("res://scenes/hosting_lobby.tscn").instantiate()
@onready var game_scene: Game = preload("res://scenes/game_scene.tscn").instantiate()

var host_server: HostServer

func _ready():
	host_server = HostServer.new()
	host_server.set_game_scene(game_scene)
	add_child(menu)
	add_child(host_server)
	randomize()

func scene_to_menu():
	if get_node_or_null("res://scenes/start_menu.tscn") == null:
		add_child(menu)

func scene_to_joining():
	if get_node_or_null("res://scenes/join_lobby.tscn") == null:
		add_child(joining_scene)
		
		
func scene_to_hosting():
	if get_node_or_null("res://scenes/hosting_lobby.tscn") == null:
		add_child(hosting_scene)
		hosting_scene.set_lobby_code(host_server.generate_lobby_code())

func scene_to_game():
	if get_node_or_null("res://scenes/game_scene.tscn") == null:
		add_child(game_scene)

func join_game():
	host_server.create_client()
	#game_scene.spawn_player()

func host_game():
	host_server.create_server()
	#game_scene.spawn_player()

func close_hosting():
	pass
	
func leave_game():
	pass
	
