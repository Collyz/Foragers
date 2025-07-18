extends Node
class_name Client

const PORT: int = 25555
var client: ENetMultiplayerPeer
var given_lobby_code: String = ""
var game_scene: Game

func _ready():
	client = ENetMultiplayerPeer.new()
	randomize()
	multiplayer.connected_to_server.connect(_connected_to_server)
	multiplayer.connection_failed.connect(_failed_connection)
	multiplayer.server_disconnected.connect(_server_disconnect)
	## Give parent a unique ID for handling synchronization
	#get_parent().name = str(multiplayer.get_unique_id())

func _connected_to_server():
	print("Connected to the server!")

func _failed_connection():
	print("Failed connect : (")

func _server_disconnect():
	print("The server has disconnected you!")

func create_client():
	if client != null:
		client.create_client("localhost", PORT)
		multiplayer.multiplayer_peer = client
		
	
func validate_code(try_code: String) -> bool:
	print("Input code: %s" % try_code)
	print("Expected code: %s" % given_lobby_code)
	return try_code == given_lobby_code

@rpc("any_peer", "call_remote", "unreliable_ordered")
func rpc_validate_code(lobby_code: String) -> bool:
	print("Host validating code: %s" % lobby_code)
	return validate_code(lobby_code)
	
