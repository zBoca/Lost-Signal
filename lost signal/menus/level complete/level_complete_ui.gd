extends Control


@onready var animator = get_parent().get_parent().get_node("scene transition animator")

func _on_next_level_button_down():
	animator.play("fade out")
	await get_tree().create_timer(1.5).timeout
	
	var current_scene = get_tree().current_scene.scene_file_path
	var next_level = current_scene.to_int() + 1
	
	get_tree().change_scene_to_file("res://levels/level_" + str(next_level) + ".tscn")


func _on_main_menu_button_down():
	animator.play("fade out")
	await get_tree().create_timer(1.5).timeout
	
	get_tree().change_scene_to_file("res://menus/title/main_menu.tscn")


func _on_restart_button_down():
	animator.play("fade out")
	await get_tree().create_timer(1.5).timeout
	
	var current_scene = get_tree().current_scene.scene_file_path
	var current_level = current_scene.to_int()
	
	get_tree().change_scene_to_file("res://levels/level_" + str(current_level) + ".tscn")
