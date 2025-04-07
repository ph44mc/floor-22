extends event

var chanceDebuff: float = 0

func animate():
	while true:
		await get_tree().create_timer(7.5).timeout
		var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(false)
		tween.tween_property($Eye, "position", Vector2(918,617), 2)
		tween.tween_property($Eye, "position", Vector2(1104,603), 3)
		tween.tween_property($Eye, "position", Vector2(992,596), 2)

func _process(delta: float) -> void:
	if main.hasItem("vase"): $CanvasLayer/CanvasGroup/VBoxContainer/Button4.disabled = false
	else: $CanvasLayer/CanvasGroup/VBoxContainer/Button4.disabled = true
	if main.guest == "knife" or main.hasItem("knife"): $CanvasLayer/CanvasGroup/VBoxContainer/Button3.disabled = false
	else: $CanvasLayer/CanvasGroup/VBoxContainer/Button3.disabled = true
	
func onStart():
	animate()
	match(main.guest):
		"hollow": chanceDebuff = 0.1
		"knife": chanceDebuff = 0.4
	$CanvasLayer/CanvasGroup/VBoxContainer/Button.text = "Stand still (%s" % ((0.5-chanceDebuff)*100) + "% success)" 
	main.shakeLoop(1)
	await get_tree().create_timer(1.6).timeout

func _on_button_pressed() -> void:
	if !chosen:
		chosen = true
		main.shakeLoop(1)
		if randf() < 0.5-chanceDebuff:
			$EventTable.visible = true
			main.enableButton()
			hideText()
		else:
			hideText()
			showText($CanvasLayer2/CanvasGroup)
			$CanvasLayer.visible = false
			
func _on_button_2_pressed() -> void:
	main.ending()
	G.giveEnding(1)

func _on_button_4_pressed() -> void:
	main.removeItem("vase")
	$EventTable.visible = true
	main.enableButton()
	hideText()

func _on_button_3_pressed() -> void:
	$EventTable.visible = true
	main.enableButton()
	hideText()
