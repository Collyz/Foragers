extends CharacterBody2D

class_name TempPlayer

@onready var anm_sprite = $AnimatedSprite2D
var max_speed = 200
var last_direction = Vector2(0, 1)

func _enter_tree() -> void:
	set_multiplayer_authority(int(str(name)))

func _physics_process(_delta: float) -> void:
	if !is_multiplayer_authority():
		return
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * max_speed
	move_and_slide()
	
	if direction.length() > 0:
		last_direction = direction
		play_walk_animation(direction)
	else:
		play_idle_animation(last_direction)
	
func play_walk_animation(direction):
	if direction.x > 0:
		anm_sprite.play("walk_right")
	elif direction.x < 0:
		anm_sprite.play("walk_left")
	elif direction.y > 0:
		anm_sprite.play("walk_down")
	elif direction.y < 0:
		anm_sprite.play("walk_up")

func play_idle_animation(direction):
	if direction.x > 0:
		anm_sprite.play("idle_right")
	elif direction.x < 0:
		anm_sprite.play("idle_left")
	elif direction.y > 0:
		anm_sprite.play("idle_down")
	elif direction.y < 0:
		anm_sprite.play("idle_up")
