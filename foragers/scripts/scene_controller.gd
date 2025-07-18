extends Node
class_name SceneControllerNode

@onready var menu = preload("res://scenes/start_menu.tscn").instantiate()
@onready var joining_scene: ClientScreen  = preload("res://scenes/join_lobby.tscn").instantiate()
@onready var hosting_scene: HostingScreen = preload("res://scenes/hosting_lobby.tscn").instantiate()
@onready var game_scene: Game = preload("res://scenes/game_scene.tscn").instantiate()

var server: Server
var client: Client

func _ready():
	server = Server.new()
	server.set_game_scene(game_scene)
	client = Client.new()
	add_child(menu, true)
	add_child(server, true)
	add_child(client, true)
	randomize()

func scene_to_menu():
	if get_node_or_null("res://scenes/start_menu.tscn") == null:
		add_child(menu, true)

func scene_to_joining():
	if get_node_or_null("res://scenes/join_lobby.tscn") == null:
		add_child(joining_scene, true)
		
func scene_to_hosting():
	if get_node_or_null("res://scenes/hosting_lobby.tscn") == null:
		add_child(hosting_scene, true)
		hosting_scene.set_lobby_code(server.generate_lobby_code())
		host_game()

func scene_to_game():
	if get_node_or_null("res://scenes/game_scene.tscn") == null:
		add_child(game_scene, true)

func join_game():
	client.create_client()

func host_game():
	server.create_server()

func get_server() -> Server:
	return server

func close_hosting():
	pass
	
func leave_game():
	pass
	
