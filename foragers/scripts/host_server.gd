extends Node
class_name HostServer

var peer: ENetMultiplayerPeer
var port_to_use: int = 25555
var expected_lobby_code: String = ""

func _ready():
	peer = ENetMultiplayerPeer.new()
	randomize()
	
func create_server():
	if peer != null:
		peer.create_server(port_to_use)
		multiplayer.multiplayer_peer = peer
		
		multiplayer.peer_connected.connect(
			func(peerID):
				print("Peer " + str(peerID) + " has joined the game!")
		)
	
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
	return result
