extends CharacterBody2D



const speed = 175
const jumpPower = -450

var recieving : bool = false
var atStation : bool = false
var atRecieveStation : bool = false
var atDoorStation : bool = false
var atSatellite : bool = false
var engagingSatellite : bool = false
var canMove : bool = true
var canRecieve : bool = true

var smoothedMousePos

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var pauseMenu = $"CanvasLayer/pause menu"
@onready var audioScene = get_tree().get_root().get_node("/root/MusicScene")

func _process(_delta):
	if (Input.is_action_just_pressed("interact") && is_on_floor() && atStation && canRecieve && !fixMyProblem) || levelCompleted:
		stopAnimation = true
		if !levelCompleted:
			animator.play("receiving mode")
		velocity = Vector2.ZERO
	elif recieving == true && (!Input.is_action_pressed("interact") || !atStation):
		recieving = false
		animator.play("unreceiving")
		await get_tree().create_timer(0.6).timeout 
		fixMyProblem = false
		canMove = true
		stopAnimation = false

	if Input.is_action_just_pressed("pause") && !levelCompleted && canMove:
		get_tree().paused = true
		signalText.hide()
		lostText.hide()
		pauseMenu.show()

	if atSatellite && is_on_floor() && Input.is_action_pressed("interact"):
		engagingSatellite = true
		animator.play("working")
		stopAnimation = true
	elif engagingSatellite == true && !Input.is_action_pressed("interact"):
		engagingSatellite = false
		stopAnimation = false

	if engagingSatellite:
		currSat.look_at(get_global_mouse_position())
		
	
	animationManager()


func playWalkAudio():
	audioScene.get_node("track audio").play()
func signalgain1():
	audioScene.get_node("signalgain1").play()
func signalgain2():
	audioScene.get_node("signalgain2").play()
func signalgain3():
	audioScene.get_node("signalgain3").play()
func signalgain4():
	audioScene.get_node("signalgain4").play()


func _physics_process(delta):
	if !is_on_floor(): #Apply Gravity
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") && is_on_floor() && canMove && !engagingSatellite: #Jump 
		if !recieving:
			velocity.y = jumpPower
	
	var direction = Input.get_axis("left", "right") #Get input direction
	
	if direction && !recieving && !engagingSatellite && canMove: #Move if theres a direction
		velocity.x = direction * speed
	else: #Stop if not
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()


func _on_recieve_station_area_entered(_area):
	atRecieveStation = true
	atStation = true
func _on_recieve_station_area_exited(_area):
	atRecieveStation = false
	atStation = false


func openDoor(doorAnimator, light):
	doorAnimator.play("open")
	light.get_node("green").show()
	light.get_node("red").hide()


var currSat
var currStation

func _on_area_check_area_entered(area):
	if area.is_in_group("satellite"):
		currSat = area.get_node("CollisionShape2D/Node2D")
		atSatellite = true
	
	if area.is_in_group("doorStation"):
		currStation = area
		atDoorStation = true
		atStation = true
func _on_area_check_area_exited(area):
	if area.is_in_group("satellite"):
		currSat = 0
		atSatellite = false
		atStation = false
		
	if area.is_in_group("doorStation"):
		currStation = 0
		atDoorStation = false


@onready var animator = get_node("AnimationPlayer")
@onready var animatedSprite = get_node("AnimatedSprite2D")
var stopAnimation : bool = false

func animationManager():
	if velocity.x < 0:
		animatedSprite.set_flip_h(true)
	elif velocity.x > 0: 
		animatedSprite.set_flip_h(false)
	
	if connectingTimer.time_left > 0 && recieving:
		stopAnimation = true
		if !levelCompleted:
			fixMyProblem = true
			animator.play("gaining signal")
				
	
	if !stopAnimation && !recieving && !fixMyProblem:
		if is_on_floor() && velocity != Vector2.ZERO:
			animator.play("walk")
		elif !is_on_floor() && velocity.y < 0:
			animator.play("jump up")
		elif !is_on_floor() && velocity.y > 0:
			animator.play("jump down")
		elif is_on_floor() && !fixMyProblem:
			animator.play("idle")


@onready var connectingTimer = get_node("connecting timer")

func resetConnectingTimer():
	connectingTimer.start()

func enableRecieving():
	recieving = true

var levelCompleted : bool = false
@onready var signalText = get_node("CanvasLayer/ui/signal text")
@onready var lostText = get_node("CanvasLayer/ui/lost text")
@onready var connectedText = get_node("CanvasLayer/ui/connected text")
@onready var levelCompleteUI = get_node("CanvasLayer/levelCompleteUI")
@onready var levelCompleteAnimator = get_node("level complete animator")
var fixMyProblem : bool = false

var endtext_1 = "Congratulations!"
var endtext_2 = "We want to thank you for your work \nas a satellite repair bot today"
var endtext_3 = "We hope you'll return another time \nand fix up some more satellites!"
@onready var textbox = $"CanvasLayer/textbox"

func levelComplete():
	if (!atDoorStation):
		animator.play("connected")
		levelCompleted = true
		signalText.hide()
		lostText.hide()
		connectedText.show()
		
		if textbox.lvlNum == 5:
			textbox.show()
			canMove = false
			canRecieve = false

			textbox.animator.play("open")
			await get_tree().create_timer(1).timeout
			
			textbox.textboxBot.frame = 3
			for letter in endtext_1:
				textbox.timer.start()
				textbox.textbox.add_text(letter)
				textbox.textSound.play()
				await textbox.timer.timeout
			await textbox.inputted
			textbox.textbox.clear()
		
			textbox.textboxBot.frame = 3
			for letter in endtext_2:
				textbox.timer.start()
				textbox.textbox.add_text(letter)
				textbox.textSound.play()
				await textbox.timer.timeout
			await textbox.inputted
			textbox.textbox.clear()
			
			textbox.textboxBot.frame = 3
			for letter in endtext_3:
				textbox.timer.start()
				textbox.textbox.add_text(letter)
				textbox.textSound.play()
				await textbox.timer.timeout
			await textbox.inputted
			textbox.textbox.clear()
		
		
			textbox.animator.play("close")
			await get_tree().create_timer(0.6).timeout
	
			textbox.hide()

		await get_tree().create_timer(1).timeout
		levelCompleteAnimator.play("level complete animation")
		levelCompleteUI.show()
	else:
		if currStation.is_in_group("2"):
			openDoor(currStation.get_node("door/AnimationPlayer"), currStation.get_node("indicatorLight"))
			openDoor(currStation.get_node("door2/AnimationPlayer"), currStation.get_node("indicatorLight"))
		else:
			openDoor(currStation.get_node("door/AnimationPlayer"), currStation.get_node("indicatorLight"))

