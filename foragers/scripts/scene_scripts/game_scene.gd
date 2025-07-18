extends Control
class_name Game

# Consts
const BOARD_SIZE: Vector2 = Vector2(2000, 1200) # Arbitrary size of the board
const SPEC_BORDER_POS = {
	"TOP_LEFT" : Vector2(0, 0),
	"TOP_RIGHT": Vector2(BOARD_SIZE.x, 0),
	"BOTTOM_LEFT" : Vector2(0, BOARD_SIZE.y),
	"BOTTOM_RIGHT": Vector2(BOARD_SIZE.x, BOARD_SIZE.y),
	"CENTER" : BOARD_SIZE/2
}

# Scenes
@onready var game_camera = $SubViewportContainerBoard/BoardSubViewport/BoardCamera
@onready var game_viewport = $SubViewportContainerBoard/BoardSubViewport
@onready var side_viewport = $SubViewportContainerSides/SideViewport
@onready var board_camera = $SubViewportContainerBoard/BoardSubViewport/BoardCamera

@onready var msg_box = $SubViewportContainerSides/SideViewport/MessageTextEdit
@onready var msg_line = $SubViewportContainerSides/SideViewport/MessageLineEdit

@onready var border_checker = preload("res://border_checker.tscn")
@onready var player = preload("res://filler.tscn")

@onready var window_size = get_viewport().get_visible_rect().size # Size of the app window
# Make game viewport 6/8 of the width and 6/8 of the screen height 
@onready var game_viewport_size = Vector2(window_size.x/8 * 6, window_size.y/8 * 6)
@onready var side_viewport_size = Vector2(window_size.x, window_size.y) # UI Viewpoint

@onready var msg_box_vals: Dictionary = { #msg box vals
	"width" : (window_size.x/8 * 2) - 10,
	"height" : (window_size.y/10) * 4,
	"x_pos" : game_viewport_size.x + 5,
	"y_pos" : 5
}
@onready var msg_line_vals: Dictionary = {
	"width" : msg_box_vals["width"],
	"x_pos" : msg_box_vals["x_pos"],
	"y_pos" : msg_box_vals["height"] + 10, # 31 is height of LineEdit, 5 is just some space between
	
}

#func _enter_tree() -> void:
	#set_multiplayer_authority(int(str(name)))

func _ready():
	# Spawn placeholders at key points on the board for sanity
	for pos_key in SPEC_BORDER_POS:
		var child = border_checker.instantiate()
		game_viewport.add_child(child)
		child.position = SPEC_BORDER_POS[pos_key]

	game_viewport.size = game_viewport_size
	side_viewport.size = side_viewport_size
	# Setting message box width, height, x, y pos
	msg_box.position = Vector2() # Start at 0,0 then move it 
	msg_box.size.x = msg_box_vals["width"]
	msg_box.size.y = msg_box_vals["height"]
	msg_box.position.x = msg_box_vals["x_pos"]
	msg_box.position.y = msg_box_vals["y_pos"]
	
	msg_line.size.x = msg_line_vals["width"]
	msg_line.position.x = msg_line_vals["x_pos"]
	msg_line.position.y = msg_line_vals["y_pos"]

func _on_line_edit_text_submitted(new_text):
	var peer_id = multiplayer.get_unique_id()
	if new_text.strip_edges() != "":
		msg_box.text += format_msg(new_text, peer_id)
		_on_text_edit_text_changed()
		msg_line.text = ""
		msg_line.grab_focus()
		scroll_to_bottom_msg_box()

func _on_text_edit_text_changed():
	var peer_id = multiplayer.get_unique_id()
	var new_text = msg_line.text
	msg_line.text = ""
	rpc("receive_text_change", peer_id, new_text)

	
@rpc("any_peer", "call_remote", "unreliable_ordered")
func receive_text_change(peer_id: int, new_text: String):
	var current_text = msg_box.text
	if new_text.strip_edges() != "":
		var formatted_text = format_msg(new_text, peer_id)
		if current_text == "":
			msg_box.text = formatted_text
		else:
			msg_box.text = current_text + formatted_text
		scroll_to_bottom_msg_box()
		
	msg_line.grab_focus()

func spawn_player(peerID: String) -> void:
	var temp_player: TempPlayer = player.instantiate()
	temp_player.name = peerID
	temp_player.position = SPEC_BORDER_POS["CENTER"]
	game_viewport.add_child(temp_player)

func format_msg(msg: String, peer_id: int):
	return "[Peer %d]: %s\n" % [peer_id, msg]
	
func scroll_to_bottom_msg_box():
	msg_box.scroll_vertical = msg_box.get_v_scroll_bar().max_value

#func _input(event):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#var mouse_pos = get_viewport().get_mouse_position()
		#print("Mouse clicked at: ", mouse_pos)
#
		#var node = _get_topmost_control_at_position(self, mouse_pos)
		#if node:
			#print("Clicked node: ", node.get_path(), " (Type: ", node.get_class(), ")")
		#else:
			#print("No Control node found at click position")
#
## Recursive function to find the topmost Control node at a position
#func _get_topmost_control_at_position(node: Node, pos: Vector2) -> Node:
	#if not node is Control or not node.visible or node.mouse_filter == MOUSE_FILTER_IGNORE:
		#return null
	#
	## Check children in reverse order (topmost rendered last)
	#for child in node.get_children():
		#if child is Control and child.get_global_rect().has_point(pos):
			#var result = _get_topmost_control_at_position(child, pos)
			#if result:
				#return result
	## If no child is found, check the node itself
	#if node.get_global_rect().has_point(pos):
		#return node
	#return null
