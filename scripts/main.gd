extends Node2D

var floor: int = 0

var screen_size: Vector2
var doShake: bool = false
var canGuest: bool = true
var guest: String = "none"
var guest_floors: int = 0
var debug: int = 0

var events: Array = [
	"res://scenes/events/event_base.tscn",
	"res://scenes/events/event_base.tscn",
	
	"res://scenes/events/event_vase.tscn",
	"res://scenes/events/event_cookies.tscn",
	
	"res://scenes/events/event_hollow.tscn",
	"res://scenes/events/event_knife.tscn",
	"res://scenes/events/event_heavy.tscn",
	
	"res://scenes/events/event_eye.tscn",
	"res://scenes/events/event_blackhole.tscn",
]

func setBackground(bg_path: String = "res://assets/elevator.png"):
	$Elevator.texture =  load(bg_path)

func _ready() -> void:
	screen_size = get_viewport_rect().size
	if !debug: events.shuffle()
	
	$AudioStreamPlayer2.play()
	shakeLoop(2)
	
	$Ending/ColorRect2.modulate[3] = 1
	$Ending.visible = true
	$Event.get_child(0).hideText()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(false)
	tween.tween_property($Ending/ColorRect2, "modulate:a", 0, 1)
	await get_tree().create_timer(1).timeout
	$Ending.visible = false
	
	await get_tree().create_timer(2).timeout
	floor+=1
	$Event.get_child(0).queue_free()
	if !debug: $Event.add_child(load(events[floor % (events.size())]).instantiate())
	else: $Event.add_child(load(events[debug]).instantiate())
	await get_tree().create_timer(1.0).timeout
	shakeLoop(2)
	shake(5)
	await get_tree().create_timer(1.45).timeout
	blink($ColorRect)
	if $Event.get_child(0).doOpenDoors:
		openDoors()

func _on_button_pressed() -> void:
	if !$Ending.visible:
		$AudioStreamPlayer.play()
		$Button.disabled = true
		nextEvent()

func openDoors():
	$Event.get_child(0).showText()
	$Floor.text = str(-floor)
	G.spawnText("Floor -"+str(floor),Vector2(screen_size[0]/2+15,130), 3, 86)
	$DoorSound.play()
	shakeLoop(0.7)
	
	if floor == 22:
		$"22".modulate[3] = 0
		$"22".visible = true
		var tween22 = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(false)
		tween22.tween_property($"22", "modulate:a", 1, 1)
		
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD).set_parallel(true)
	tween.tween_property($leftDoor, "position", $leftDoor.position + Vector2(-140,0), 1.2)
	tween.tween_property($rightDoor, "position", $rightDoor.position + Vector2(140,0), 1.2)
	await get_tree().create_timer(1).timeout
	if guest_floors==0:
		if guest == "knife":
			addItem("res://scenes/items/item_knife.tscn")
			G.spawnText("Take this. It will help.",Vector2(get_viewport_rect().size[0]/2-145,get_viewport_rect().size[1]-140), 5, 25)
		guest = "none"
		canGuest = true
		setBackground()
	shakeLoop(0.7)
	
func closeDoors():
	shakeLoop(0.7)
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD).set_parallel(true)
	tween.tween_property($leftDoor, "position", $leftDoor.position + Vector2(140,0), 1.2)
	tween.tween_property($rightDoor, "position", $rightDoor.position + Vector2(-140,0), 1.2)
	await get_tree().create_timer(1).timeout
	shakeLoop(0.7)
	
func nextEvent():
	$Event.get_child(0).hideText()
	shake(1)
	await get_tree().create_timer(0.5).timeout
	closeDoors()
	await get_tree().create_timer(1.8).timeout
	shake(5)
	floor+=1
	await get_tree().create_timer(0.1).timeout
	shakeLoop(1)
	$Event.get_child(0).queue_free()
	if floor < 21:
		if !debug: $Event.add_child(load(events[floor % (events.size())]).instantiate())
		else: $Event.add_child(load(events[debug]).instantiate())
	if floor == 22:
		$Event.add_child(load("res://scenes/events/event_22.tscn").instantiate())
	if floor == 21:
		$Event.add_child(load("res://scenes/events/event_base.tscn").instantiate())
		showLeave()
		guest_floors=0
	elif $Event.get_child(0).canLeave:
		guest_floors-=1
		if guest_floors==0:
			showLeave()
	await get_tree().create_timer(2.9).timeout
	shakeLoop(1)
	shake(5)
	await get_tree().create_timer(1.45).timeout
	blink($ColorRect)
	if $Event.get_child(0).doOpenDoors:
		openDoors()
	
func addItem(item_path: String):
	if $CanvasLayer/Items.get_child_count()<2:
		var item = load(item_path).instantiate()
		$CanvasLayer/Items.add_child(item)
		$CanvasLayer/ItemCount.visible = true
		$CanvasLayer/ItemCount.text = str($CanvasLayer/Items.get_child_count())+"/2"
		return true
	return false
	
func removeItem(item):
	$CanvasLayer/ItemCount.text = str($CanvasLayer/Items.get_child_count())+"/2"
	if item is String:
		for i in $CanvasLayer/Items.get_children():
			if i.item == item:
				i.queue_free()
	else:
		item.queue_free()
		await get_tree().create_timer(0.05).timeout
	if $CanvasLayer/Items.get_child_count()<=0:
		$CanvasLayer/ItemCount.visible = false
	
func hasItem(item: String):
	for i in $CanvasLayer/Items.get_children():
		if i.item == item:
			return true
	return false
	
func enableButton():
	$Button.disabled = false
	
func shakeLoop(power = 1):
	doShake = !doShake
	while doShake:
		await get_tree().create_timer(0.2).timeout
		var rnd_power = randi_range(power,power*2)
		var hurtTween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE).set_parallel(false)
		hurtTween.tween_property($Camera2D, "position", Vector2(-rnd_power,-rnd_power), 0.05)
		hurtTween.tween_property($Camera2D, "position", Vector2(rnd_power/2,rnd_power/2), 0.05)
		hurtTween.tween_property($Camera2D, "position", Vector2(0,0), 0.1)

func shake(power = 1):
	var hurtTween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE).set_parallel(false)
	hurtTween.tween_property($Camera2D, "position", Vector2(-power,-power), 0.05)
	hurtTween.tween_property($Camera2D, "position", Vector2(power/2,power/2), 0.05)
	hurtTween.tween_property($Camera2D, "position", Vector2(0,0), 0.1)

func blink(obj):
	for i in 6:
		obj.visible = !obj.visible
		await get_tree().create_timer(randf()/10).timeout
		
func showLeave():
	$CanvasLayer/Leave.visible = true
	$CanvasLayer/Leave.modulate[3] = 0
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(false)
	tween.tween_property($CanvasLayer/Leave, "modulate:a", 1, 1)
	tween.tween_property($CanvasLayer/Leave, "modulate:a", 1, 2)
	tween.tween_property($CanvasLayer/Leave, "modulate:a", 0, 1)
	await get_tree().create_timer(4).timeout
	$CanvasLayer/Leave.visible = true
		
func ending():
	$Ending.visible = true
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(true)
	tween.tween_property($Ending/ColorRect2, "modulate:a", 1, 3)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
