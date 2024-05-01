extends Node2D



var direction = Vector2(1.0, 0.0)
var speed = 250.0

func _process(delta):
	position = position + speed * direction * delta


@onready var player = get_tree().get_root().get_node(str(get_tree().current_scene.name) + "/CharacterBody2D")

func _on_area_2d_area_entered(area):
	if area.is_in_group("satellite dish") && !area.is_in_group("initialEmitter"):
		area.get_parent().resetEmissionTimer()
		queue_free()
	elif area.is_in_group("player"):
		if area.get_parent().recieving && area.get_parent().atStation:
			area.get_parent().resetConnectingTimer()
			queue_free()
	elif area.is_in_group("recieve station grace zone"):
		if player.recieving && player.atRecieveStation:
			player.resetConnectingTimer()
			queue_free()
	elif !area.is_in_group("signal beam") && !area.is_in_group("satellite"):
		queue_free()
	
