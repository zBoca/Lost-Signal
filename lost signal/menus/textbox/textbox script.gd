extends Control


@onready var character = get_tree().get_root().get_node(str(get_tree().current_scene.name) + "/CharacterBody2D")
@onready var timer = character.get_node("text timer")
@onready var textbox = $"RichTextLabel"
@onready var textSound = get_tree().get_root().get_node("/root/MusicScene/text audio")

@onready var currentScene = get_tree().current_scene.scene_file_path

@onready var textboxBot = $"textBot/AnimatedSprite2D"

@onready var animator = $"textbox animator"

signal inputted


var level1_1 = "Hello there!"
var level1_2 = "\nToday marks your first day as a \nsatellite repair bot!"
var level1_3 = "You're first job is gonna be pretty \nsimple."
var level1_4 = "A critical system error resulted in \nthe satellites being forced to \nreboot into safemode."
var level1_5 = "Because of this, we can't remotely \naccess the satellites, so it will be \nyour job to adjust it manually."
var level1_6 = "All you gotta do is get to the \nsatellite and start adjusting it so \nthe signal gets redirected."
var level1_7 = "Once you get it aimed correctly, \nyou can switch over to RECEIVE \nmode."
var level1_8 = "That way you can channel that \nsignal into the receive station and \nrestore the signal!"


var level2_1 = "Good job on your first assignment!"
var level2_2 = "\n\nTime to do it again!"
var level2_3 = "This time, there isn't a direct line \nfrom our signal to the receiving \nstation."
var level2_4 = "But don't worry!"
var level2_5 = "\n\nYou'll just need to redirect it."
var level2_6 = "You can use the inactive satellite \nto boost your signal so you can \nmake it to the receive station."
var level2_7 = "\nGood luck!"


var level3_1 = "This time it looks like there's a \ndoor blocking the way..."
var level3_2 = "But I can't signal to the control \nstation to open it up with this the \nsignal loss."
var level3_3 = "If you want to reconnect the \nsignal, first you're gonna have to \nconnect to the control station."
var level3_4 = "That way we can get the door open, \nand then we can worry about \nrestoring the connection!"


var level4_1 = "Looks like another door is in the \nway, but if you open that up \nit will block you off..."
var level4_2 = "No worries! Even if it blocks off\none path, another one will be\navailable to use"


var level5_1 = "This should be your last job for\ntoday!"
var level5_2 = "This is combining everything youve \nlearned so far, so I'm sure \nyou got this!"

var lvlNum


func _ready():
	lvlNum = currentScene.to_int()
	
	
	if lvlNum == 1:
		level1Text()
	elif lvlNum == 2:
		level2Text()
	elif lvlNum == 3:
		level3Text()
	elif lvlNum == 4:
		level4Text()
	elif lvlNum == 5:
		character.get_node("CanvasLayer/levelCompleteUI/next level button").hide()
		level5Text()

func _input(event):
	if event.is_action_pressed("advance text"):
		inputted.emit()
		

func level1Text():
	character.canMove = false
	character.canRecieve = false
	
	await get_tree().create_timer(0.7).timeout
	
	animator.play("open")
	show()
	await get_tree().create_timer(1).timeout
	
	textboxBot.frame = 3
	for letter in level1_1:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	
	textboxBot.frame = 2
	for letter in level1_2:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 2
	for letter in level1_3:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 0
	for letter in level1_4:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 4
	for letter in level1_5:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 1
	for letter in level1_6:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 2
	for letter in level1_7:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 3
	for letter in level1_8:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	animator.play("close")
	await get_tree().create_timer(0.6).timeout
	
	hide()
	
	await get_tree().create_timer(0.5).timeout
	
	character.canMove = true
	character.canRecieve = true

func level2Text():
	character.canMove = false
	character.canRecieve = false
	
	await get_tree().create_timer(0.7).timeout
	
	animator.play("open")
	show()
	await get_tree().create_timer(1).timeout
	
	textboxBot.frame = 3
	for letter in level2_1:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	
	textboxBot.frame = 4
	for letter in level2_2:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 1
	for letter in level2_3:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 3
	for letter in level2_4:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	
	textboxBot.frame = 2
	for letter in level2_5:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 2
	for letter in level2_6:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 3
	for letter in level2_7:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	animator.play("close")
	await get_tree().create_timer(0.6).timeout
	
	hide()
	
	await get_tree().create_timer(0.5).timeout
	
	character.canMove = true
	character.canRecieve = true

func level3Text():
	character.canMove = false
	character.canRecieve = false
	
	await get_tree().create_timer(0.7).timeout
	
	animator.play("open")
	show()
	await get_tree().create_timer(1).timeout
	
	
	textboxBot.frame = 0
	for letter in level3_1:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 4
	for letter in level3_2:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 2
	for letter in level3_3:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 3
	for letter in level3_4:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	
	animator.play("close")
	await get_tree().create_timer(0.6).timeout
	
	hide()
	
	await get_tree().create_timer(0.5).timeout
	
	character.canMove = true
	character.canRecieve = true

func level4Text():
	character.canMove = false
	character.canRecieve = false
	
	await get_tree().create_timer(0.7).timeout
	
	animator.play("open")
	show()
	await get_tree().create_timer(1).timeout
	
	
	textboxBot.frame = 4
	for letter in level4_1:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	textboxBot.frame = 3
	for letter in level4_2:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	
	animator.play("close")
	await get_tree().create_timer(0.6).timeout
	
	hide()
	
	await get_tree().create_timer(0.5).timeout
	
	character.canMove = true
	character.canRecieve = true

func level5Text():
	character.canMove = false
	character.canRecieve = false
	
	await get_tree().create_timer(0.7).timeout
	
	animator.play("open")
	show()
	await get_tree().create_timer(1).timeout
	
	

	textboxBot.frame = 2
	for letter in level5_1:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	
	
	textboxBot.frame = 3
	for letter in level5_2:
		timer.start()
		textbox.add_text(letter)
		textSound.play()
		await timer.timeout
	await inputted
	textbox.clear()
	
	
	
	animator.play("close")
	await get_tree().create_timer(0.6).timeout
	
	hide()
	
	await get_tree().create_timer(0.5).timeout
	
	character.canMove = true
	character.canRecieve = true
