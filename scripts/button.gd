extends Button

func _on_mouse_entered() -> void:
	text = "> "+text
	

func _on_mouse_exited() -> void:
	text = text.substr(2)


func _on_pressed() -> void:
	$AudioStreamPlayer.play()
