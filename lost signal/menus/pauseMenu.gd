extends Control



func _on_level_select_button_down():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/title/main_menu.tscn")

@onready var signalText = get_parent().get_node("ui/signal text")
@onready var lostText = get_parent().get_node("ui/lost text")

func _on_resume_button_down():
	get_tree().paused = false
	signalText.show()
	lostText.show()
	hide()
