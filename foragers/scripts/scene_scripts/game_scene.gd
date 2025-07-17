extends Control
class_name Game

const BOARD_SIZE: Vector2 = Vector2(2000, 1200)
const SPEC_BORDER_POS = {
	"TOP_LEFT" : Vector2(0, 0),
	"TOP_RIGHT": Vector2(BOARD_SIZE.x, 0),
	"BOTTOM_LEFT" : Vector2(0, BOARD_SIZE.y),
	"BOTTOM_RIGHT": Vector2(BOARD_SIZE.x, BOARD_SIZE.y),
	"CENTER" : BOARD_SIZE/2
}

@onready var game_camera = $SubViewportContainerBoard/BoardSubViewport/BoardCamera
@onready var game_viewport = $SubViewportContainerBoard/BoardSubViewport
@onready var side_viewport = $SubViewportContainerSides/SideViewport
@onready var message_box = $SubViewportContainerSides/SideViewport/TextEdit
@onready var board_camera = $SubViewportContainerBoard/BoardSubViewport/BoardCamera

@onready var border_checker = preload("res://border_checker.tscn")
@onready var player = preload("res://filler.tscn")

var screen_size: Vector2

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	
	for pos_key in SPEC_BORDER_POS:
		var child = border_checker.instantiate()
		game_viewport.add_child(child)
		child.position = SPEC_BORDER_POS[pos_key]
	
	# Make viewport 7/8 of the screen height and 5/6 of the width
	game_viewport.size = Vector2(screen_size.x/8 * 6, screen_size.y/8 * 6)
	# Make sideviewport the same size as the screen since it's behind the board anyways
	side_viewport.size = Vector2(screen_size.x, screen_size.y)
	
	game_camera.position_smoothing_enabled = false;
	game_camera.position_smoothing_enabled = true;
	
	# Setting message box width and height
	message_box.size.x = (screen_size.x/6) - 10
	message_box.size.y = (screen_size.y/10) * 4
	message_box.position.x = 0
	message_box.position.x = (screen_size.x/6 * 5) + 5
	message_box.position.y += 5

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_viewport().get_mouse_position()
		print("Mouse clicked at: ", mouse_pos)

		# Get the node under the mouse
		var viewport = get_viewport()
		var node = _get_topmost_control_at_position(self, mouse_pos)
		if node:
			print("Clicked node: ", node.get_path(), " (Type: ", node.get_class(), ")")
		else:
			print("No Control node found at click position")

# Recursive function to find the topmost Control node at a position
func _get_topmost_control_at_position(node: Node, pos: Vector2) -> Node:
	if not node is Control or not node.visible or node.mouse_filter == MOUSE_FILTER_IGNORE:
		return null
	
	# Check children in reverse order (topmost rendered last)
	for child in node.get_children():
		if child is Control and child.get_global_rect().has_point(pos):
			var result = _get_topmost_control_at_position(child, pos)
			if result:
				return result
	# If no child is found, check the node itself
	if node.get_global_rect().has_point(pos):
		return node
	return null

func spawn_player(peerID: String) -> void:
	var temp_player: TempPlayer = player.instantiate()
	temp_player.name = peerID
	game_viewport.add_child(temp_player)
	
