extends event

func _on_button_pressed() -> void:
	if !chosen:
		if main.addItem("res://scenes/items/item_cookies.tscn"):
			$EventTable.visible = true
			chosen = true
			main.enableButton()
			hideText()

func _on_button_2_pressed() -> void:
	if !chosen:
		chosen = true
		main.enableButton()
		hideText()
