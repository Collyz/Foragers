extends Control
class_name ClientScreen

var parent: SceneControllerNode

func _ready():
	parent = get_parent()
	
func _input(_event):
	pass
	
func _on_back_button_pressed() -> void:
	parent.remove_child(self)
	parent.scene_to_menu()


func _on_join_game_button_pressed() -> void:
	parent.remove_child(self)
	#parent.scene_to_game()
	parent.join_game()
