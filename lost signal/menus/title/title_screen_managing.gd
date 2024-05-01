extends Control



@onready var mainMenuUI = $"main menu"
@onready var levelSelectUI = $"level select"
@onready var animator = get_tree().get_root().get_node("/root/Title Screen/AnimationPlayer")
@onready var uiAnimator = get_tree().get_root().get_node("/root/Title Screen/Camera2D/CanvasLayer/title screen ui/AnimationPlayer")
@onready var transitionAnimator = get_tree().get_root().get_node("/root/Title Screen/Camera2D/CanvasLayer/title screen ui/scene transition")

var canButton : bool = true


func doCanButton():
	canButton = true
func cantButton():
	canButton = false


func _ready():
	uiAnimator.play("RESET")


func _on_quit_button_button_down():
	if canButton:
		transitionAnimator.play("fade out")
		await get_tree().create_timer(0.7).timeout
		
		get_tree().quit()


func _on_play_button_button_down():
	if canButton:
		animator.play("toLevelSelect")
		uiAnimator.play("toLevelSelect")



func _on_back_button_button_down():
	if canButton:
		animator.play("toMainMenu")
		uiAnimator.play("toMainMenu")


func _on_level_1_button_down():
	if canButton:
		transitionAnimator.play("fade out")
		await get_tree().create_timer(0.7).timeout
		
		get_tree().change_scene_to_file("res://levels/level_1.tscn")
func _on_level_2_button_down():
	if canButton:
		transitionAnimator.play("fade out")
		await get_tree().create_timer(0.7).timeout
		
		get_tree().change_scene_to_file("res://levels/level_2.tscn")
func _on_level_3_button_down():
	if canButton:
		transitionAnimator.play("fade out")
		await get_tree().create_timer(0.7).timeout
		
		get_tree().change_scene_to_file("res://levels/level_3.tscn")
func _on_level_4_button_down():
	if canButton:
		transitionAnimator.play("fade out")
		await get_tree().create_timer(0.7).timeout
		
		get_tree().change_scene_to_file("res://levels/level_4.tscn")
func _on_level_5_button_down():
	if canButton:
		transitionAnimator.play("fade out")
		await get_tree().create_timer(0.7).timeout
		
		get_tree().change_scene_to_file("res://levels/level_5.tscn")
