extends Node2D

@onready var settings_menu = preload("res://settings_menu.tscn").instantiate()
@onready var camera = $Camera2D


var dragging := false
var last_mouse_position := Vector2.ZERO

var world_size = Vector2(0, 0)  # Replace with your game world size
var min_zoom = 1
var max_zoom = 1.8
var zoom_step = 0.1

func _ready():
	var size = get_viewport().get_visible_rect().size
	world_size = size
	print("Viewport size is: ", size)


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if Input.is_action_pressed("left_click") and event.pressed:
			dragging = true
			last_mouse_position = event.position
		elif not event.pressed:
			dragging = false

	elif event is InputEventMouseMotion and dragging:
		var delta = event.position - last_mouse_position
		camera.position -= delta / camera.zoom
		last_mouse_position = event.position
		clamp_camera_to_world()

	# Zoom input
	if Input.is_action_just_pressed("mouse_wheel_up"):
		zoom_camera(zoom_step)
	elif Input.is_action_just_pressed("mouse_wheel_down"):
		zoom_camera(-zoom_step)

func zoom_camera(amount: float):
	var new_zoom = camera.zoom + Vector2.ONE * amount
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	camera.zoom = new_zoom
	clamp_camera_to_world()

func clamp_camera_to_world():
	var half_screen = get_viewport_rect().size * 0.5 / camera.zoom
	var min_pos = half_screen
	var max_pos = world_size - half_screen

	camera.position = camera.position.clamp(min_pos, max_pos)
