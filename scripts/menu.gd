extends Node2D

func _ready() -> void:
	if G.newEnding:
		G.newEnding = false
		G.spawnText("New ending unlocked.",Vector2(get_viewport_rect().size[0]/2-185,get_viewport_rect().size[1]-140), 5, 45)
	for i in 5:
		if G.endings[i] == 0:
			$CanvasGroup2.get_child(i).texture = load("res://assets/ending/ending0.png")
	$Ending/ColorRect2.modulate[3] = 1
	$Ending.visible = true
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(false)
	tween.tween_property($Ending/ColorRect2, "modulate:a", 0, 1)
	await get_tree().create_timer(1).timeout
	$Ending.visible = false

func _on_button_pressed() -> void:
	$Ending/ColorRect2.modulate[3] = 0
	$Ending.visible = true
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(true)
	tween.tween_property($Ending/ColorRect2, "modulate:a", 1, 2)
	tween.tween_property($AudioStreamPlayer, "volume_db", -80, 4)
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_button_2_pressed() -> void:
	$Ending/ColorRect2.modulate[3] = 0
	$Ending.visible = true
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(false)
	tween.tween_property($Ending/ColorRect2, "modulate:a", 1, 1)
	tween.tween_property($Ending/ColorRect2, "modulate:a", 1, 0.2)
	tween.tween_property($Ending/ColorRect2, "modulate:a", 0, 1)
	await get_tree().create_timer(1).timeout
	$CanvasGroup.visible = false
	$Ending.visible = false
	$CanvasGroup2.visible = true
	$CanvasGroup2.modulate[3] = 0
	var tween2 = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(false)
	tween2.tween_property($CanvasGroup2, "modulate:a", 1, 1)
	
func _on_button_back_pressed() -> void:
	var tween2 = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(false)
	tween2.tween_property($CanvasGroup2, "modulate:a", 0, 1)
	await get_tree().create_timer(1).timeout
	$CanvasGroup2.visible = false
	$CanvasGroup.visible = true
	$CanvasGroup.modulate[3] = 0
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(false)
	tween.tween_property($CanvasGroup, "modulate:a", 1, 1)
