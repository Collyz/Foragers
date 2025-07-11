extends Control

@onready var back_button = $BackButton
var parent: SceneControllerNode

func _ready():
	parent = get_parent()
	
func _input(event):
	pass
	
func _on_back_button_pressed():
	parent.remove_child(self)
	parent.scene_to_menu()
