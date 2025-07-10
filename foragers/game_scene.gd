extends Control

@onready var settings_menu = preload("res://settings_menu.tscn").instantiate()
@onready var board_camera = $SubViewportContainerBoard/SubViewport/BoardCamera


var dragging := false
var last_mouse_position := Vector2.ZERO

var board_size = Vector2(0, 0)
var screen_size = Vector2(0, 0)
var min_zoom = 1
var max_zoom = 3
var zoom_step = 0.1

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	board_size = board_camera.get_viewport().get_visible_rect().size

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if Input.is_action_pressed("left_click") and event.pressed:
			dragging = true
			last_mouse_position = event.position
		elif not event.pressed:
			dragging = false

	elif event is InputEventMouseMotion and dragging:
		var delta = event.position - last_mouse_position
		board_camera.position -= delta / board_camera.zoom
		last_mouse_position = event.position
		clamp_camera_to_world()

	# Zoom input
	if Input.is_action_just_pressed("mouse_wheel_up"):
		if get_node_or_null("SettingsControl") == null:
			zoom_camera(zoom_step)
	elif Input.is_action_just_pressed("mouse_wheel_down"):
		if get_node_or_null("SettingsControl") == null:
			zoom_camera(-zoom_step)

func zoom_camera(amount: float):
	var new_zoom = board_camera.zoom + Vector2.ONE * amount
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	board_camera.zoom = new_zoom
	clamp_camera_to_world()

func clamp_camera_to_world():
	var half_screen = board_camera.get_viewport_rect().size * 0.5 / board_camera.zoom
	var min_pos = half_screen
	var max_pos = board_size - half_screen

	board_camera.position = board_camera.position.clamp(min_pos, max_pos)
