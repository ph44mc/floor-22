extends event

var blackhole: bool = false

func onStart():
	showText()

func _process(delta: float) -> void:
	$EventTable.rotation_degrees += 4
	if blackhole: 
		if $CanvasLayer/CanvasGroup/TextureProgressBar.value <= 70:
			$CanvasLayer/CanvasGroup/ButtonBH.visible = true
		$CanvasLayer/CanvasGroup/TextureProgressBar.value -= 1
		if $CanvasLayer/CanvasGroup/TextureProgressBar.value >= 100:
			doOpenDoors = true
			blackhole = false
			main.shakeLoop(7)
			hideText($CanvasLayer/CanvasGroup/TextureProgressBar/Label)
			$CanvasLayer/CanvasGroup/ButtonBH.visible = false
			await get_tree().create_timer(0.1).timeout
			main._on_button_pressed()
		if $CanvasLayer/CanvasGroup/TextureProgressBar.value <= 0:
			main.ending()
			G.giveEnding(2)

func _on_button_bh_pressed() -> void:
	$CanvasLayer/CanvasGroup/TextureProgressBar.value += 14

func _on_button_pressed() -> void:
	if !chosen:
		chosen = true
		main.openDoors()
		showText($CanvasLayer/CanvasGroup/TextureProgressBar/Label)
		hideText($CanvasLayer/CanvasGroup/VBoxContainer/Button)
		await get_tree().create_timer(1.4).timeout
		G.spawnText("Click anywere to hold yourself",Vector2(get_viewport_rect().size[0]/2-145,get_viewport_rect().size[1]-140), 5, 25)
		main.shakeLoop(7)
		main.guest = "none"
		main.canGuest = true
		main.setBackground()
		blackhole = true
