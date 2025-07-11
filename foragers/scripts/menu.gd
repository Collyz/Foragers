extends Control

var parent: SceneControllerNode = null
func _ready():
	parent = get_parent()

func _input(event):
	pass

func _on_join_game_button_pressed():
	parent.remove_child(self)
	parent.scene_to_joining()


func _on_host_game_button_pressed():
	parent.remove_child(self)
	parent.scene_to_hosting()
