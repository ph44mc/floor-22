extends event

func _process(delta: float) -> void:
	if !main.canGuest: $CanvasLayer/CanvasGroup/VBoxContainer/Button.disabled = true
	else: $CanvasLayer/CanvasGroup/VBoxContainer/Button.disabled = false
	if main.hasItem("knife"): $CanvasLayer/CanvasGroup/VBoxContainer/Button3.disabled = false
	else: $CanvasLayer/CanvasGroup/VBoxContainer/Button3.disabled = true
	if main.hasItem("cookies"): $CanvasLayer/CanvasGroup/VBoxContainer/Button4.disabled = false
	else: $CanvasLayer/CanvasGroup/VBoxContainer/Button4.disabled = true
	
func end():
	main.closeDoors()
	main.shake(7)
	await get_tree().create_timer(1.5).timeout
	main.shake(7)
	await get_tree().create_timer(0.5).timeout
	main.setBackground()
	main.shakeLoop(15)
	await get_tree().create_timer(3.5).timeout
	main.shakeLoop(15)
	await get_tree().create_timer(0.05).timeout
	main.shake(40)
	await get_tree().create_timer(0.5).timeout
	main.ending()
	G.giveEnding(3)
	
func _on_button_pressed() -> void:
	if !chosen:
		if main.canGuest:
			main.canGuest = false
			main.guest = "heavy"
			main.guest_floors = randi_range(1,4)
			main.setBackground("res://assets/events/elevator_heavy.png")
			$EventTable.visible = true
			end()
			chosen = true
			hideText()

func _on_button_2_pressed() -> void:
	if !chosen:
		chosen = true
		if randf() < 0.5:
			main.enableButton()
			hideText()
		else:
			main.canGuest = false
			main.guest = "heavy"
			main.guest_floors = randi_range(1,4)
			main.setBackground("res://assets/events/elevator_heavy.png")
			$EventTable.visible = true
			end()
			hideText()

func _on_button_3_pressed() -> void:
	if !chosen:
		chosen = true
		if randf() < 0.7:
			main.enableButton()
			hideText()
		else:
			main.canGuest = false
			main.guest = "heavy"
			main.guest_floors = randi_range(1,4)
			main.setBackground("res://assets/events/elevator_heavy.png")
			$EventTable.visible = true
			end()
			hideText()

func _on_button_4_pressed() -> void:
	if !chosen:
		chosen = true
		main.enableButton()
		hideText()
