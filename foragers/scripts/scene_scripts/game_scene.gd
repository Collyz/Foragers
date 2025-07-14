extends Control
class_name Game


@onready var game_camera = $SubViewportContainerBoard/BoardSubViewport/BoardCamera
@onready var game_viewport = $SubViewportContainerBoard/BoardSubViewport
@onready var side_viewport = $SubViewportContainerSides/SubViewport
@onready var player = preload("res://filler.tscn")

var dragging := false
var last_mouse_position := Vector2.ZERO

var board_size = Vector2(0, 0)
var screen_size = Vector2(0, 0)
var min_zoom = .8
var max_zoom = 3
var zoom_step = 0.01

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	board_size = Vector2(2000, 1300)
	
	# Make viewport 7/8 of the screen height and 5/6 of the width
	game_viewport.size = Vector2(screen_size.x/6 * 5, screen_size.y/8 * 7)
	# Make sideviewport the same size as the screen since it's behind the board anyways
	side_viewport.size = Vector2(screen_size.x, screen_size.y)
	
	game_camera.position_smoothing_enabled = false;
	game_camera.position = Vector2(game_viewport.size.x/2, game_viewport.size.y/2)
	game_camera.position_smoothing_enabled = true;
	
func _input(_event):
	pass

func spawn_player(peerID: String) -> void:
	var temp_player: TempPlayer = player.instantiate()
	temp_player.name = peerID
	game_viewport.add_child(temp_player)
