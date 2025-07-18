extends Node
class_name HostServer

var peer: ENetMultiplayerPeer
var port_to_use: int = 25555
var expected_lobby_code: String = ""
var game_scene: Game

func _ready():
	peer = ENetMultiplayerPeer.new()
	randomize()
	
	## Give parent a unique ID for handling synchronization
	#get_parent().name = str(multiplayer.get_unique_id())
	
func create_server():
	if peer != null:
		peer.create_server(port_to_use)
		multiplayer.multiplayer_peer = peer
		
		multiplayer.peer_connected.connect(
			func(peerID):
				print("Peer " + str(peerID) + " has joined the game!")
				#add_player(peerID)
		)
	#add_player(multiplayer.get_unique_id())
	
func close_server():
	if peer != null:
		print("Closing server...")
		peer.close()  # Cleanly shutdown the ENet server
		multiplayer.multiplayer_peer = null  # Detach from multiplayer
		peer = null  # Optional: free the peer instance

	
func create_client():
	if peer != null:
		peer.create_client("localhost", port_to_use)
		multiplayer.multiplayer_peer = peer
		

### Generates and sets a random 6-character lobby code using A-Z and 0-9
### @return A random uppercase alphanumeric string.
func generate_lobby_code() -> String:
	var result := ""
	
	for i in range(6):
		var value: int
		# Letter or Number
		if randi() % 2 == 0:
			# A-Z: 65–90
			value = randi() % 26 + 65
		else:
			# 0–9: 48–57
			value = randi() % 10 + 48
			
		result += char(value)
	
	expected_lobby_code = result
	print("Expected code: %s" % expected_lobby_code)
	return result

func add_player(peerID):
	if game_scene != null:
		game_scene.spawn_player(str(peerID))
	else:
		print("game scene null")

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
