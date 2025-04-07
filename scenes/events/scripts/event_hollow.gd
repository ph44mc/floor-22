extends event

func _process(delta: float) -> void:
	if !main.canGuest: $CanvasLayer/CanvasGroup/VBoxContainer/Button.disabled = true
	else: $CanvasLayer/CanvasGroup/VBoxContainer/Button.disabled = false

func _on_button_pressed() -> void:
	if !chosen:
		if main.canGuest:
			main.canGuest = false
			main.guest = "hollow"
			main.guest_floors = randi_range(1,4)
			main.setBackground("res://assets/events/elevator_hollow.png")
			$EventTable.visible = true
			chosen = true
			main.enableButton()
			hideText()

func _on_button_2_pressed() -> void:
	if !chosen:
		chosen = true
		main.enableButton()
		hideText()
