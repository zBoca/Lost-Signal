extends Sprite2D



var beamCooldown : bool = true
@onready var parentNode = get_parent().get_parent().get_parent()
@onready var emissionMark = get_node("Marker2D")

func _process(_delta):
	if beamCooldown && (parentNode.is_in_group("initialEmitter") || parentNode.is_in_group("connection made")):
		var direction = Vector2(-1.0, 0.0).rotated(rotation).normalized()
		var beam = preload("signal_beam/singal_beam.tscn").instantiate()
		
		beam.direction = direction
		
		beam.transform = emissionMark.transform
		
		add_child(beam)
		
		beamCooldown = false
		
		await get_tree().create_timer(0.5).timeout
		beamCooldown = true
	
	if timer.time_left > 0:
		parentNode.add_to_group("connection made")
	else:
		parentNode.remove_from_group("connection made")


@onready var timer = get_node("Timer")

func resetEmissionTimer():
	timer.start()
