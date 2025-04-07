extends event

func _on_button_pressed() -> void:
	if !chosen:
		chosen = true
		main.enableButton()
		hideText()

func _on_button_2_pressed() -> void:
	if !chosen:
		chosen = true
		main.ending()
		G.giveEnding(0)
