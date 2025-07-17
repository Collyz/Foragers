extends Camera2D

var MIN_ZOOM = .5
var MAX_ZOOM = 2
var ZOOM_STEP = 0.05

var board_size: Vector2

@onready var parent = $"../../.."

func _ready():
	# Board size from game script
	board_size = parent.BOARD_SIZE
	# Camerar to center of the baord
	position = board_size * 0.5 
	print(self.position)
	clamp_camera()

func _input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			position -= event.relative / zoom
			clamp_camera()
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				adjust_zoom(-ZOOM_STEP)
				clamp_camera()
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				adjust_zoom(ZOOM_STEP)
				clamp_camera()

func clamp_camera():
	var viewport_size = get_viewport_rect().size
	var half_screen = (viewport_size * 0.5) / zoom

	var min_pos = half_screen
	var max_pos = board_size - half_screen

	position.x = clamp(position.x, min_pos.x, max_pos.x)
	position.y = clamp(position.y, min_pos.y, max_pos.y)


func adjust_zoom(step: float):
	zoom.x = clamp(zoom.x + step, MIN_ZOOM, MAX_ZOOM)
	zoom.y = clamp(zoom.y + step, MIN_ZOOM, MAX_ZOOM)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			position -= event.relative / zoom
	pass
