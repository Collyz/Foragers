extends Node
class_name Server

const PORT: int = 25555
const MAX_CLIENTS = 8
var server: ENetMultiplayerPeer

var expected_lobby_code: String = ""
var game_scene: Game

func _ready():
	server = ENetMultiplayerPeer.new()
	randomize()
	multiplayer.peer_connected.connect(_peer_connected)
	multiplayer.peer_disconnected.connect(_peer_disconnected)
	
	## Give parent a unique ID for handling synchronization
	#get_parent().name = str(multiplayer.get_unique_id())
	
func create_server():
	if server != null:
		server.create_server(PORT, MAX_CLIENTS)
		multiplayer.multiplayer_peer = server


func _peer_connected(peer_id: int):
	print("Peer %s has joined the game!" % str(peer_id))

func _peer_disconnected(peer_id: int):
	print("Peer %s has left the game!" % str(peer_id))

func close_server():
	if server != null:
		print("Closing server...")
		multiplayer.multiplayer_peer = null  # Terminate networking


func player_connected(id):
	print("Player " + str(id) + " connected to Server")
	rpc_id(id, &"testing_to_client")

func player_disconnected(id):
	print("Player " + str(id) + " left the Server")


### Generates and sets a random 6-character lobby code using A-Z and 0-9
### @return A random uppercase alphanumeric string.
func generate_lobby_code() -> String:
	var result := ""
	for i in range(6):
		var value: int
		if randi() % 2 == 0:
			value = randi() % 26 + 65 # A-Z: 65–90
		else:
			value = randi() % 10 + 48 # 0–9: 48–57
		result += char(value)
	expected_lobby_code = result
	print("Expected code: %s" % expected_lobby_code)
	return result

#func add_player(peerID):
	#if game_scene != null:
		#game_scene.spawn_player(str(peerID))
	#else:
		#print("game scene null")

func set_game_scene(scene: Game) -> void:
	game_scene = scene
	
func validate_code(try_code: String) -> bool:
	print("Input code: %s" % try_code)
	print("Expected code: %s" % expected_lobby_code)
	return try_code == expected_lobby_code

@rpc("any_peer", "call_remote", "unreliable_ordered")
func rpc_validate_code(lobby_code: String) -> bool:
	print("Host validating code: %s" % lobby_code)
	return validate_code(lobby_code)
