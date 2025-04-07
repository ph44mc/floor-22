extends Label

func _ready() -> void:
	modulate[3] = 0

func animate(txt, showTime: float = 1.0):
	position.x -= get_theme_font("font").get_string_size(text, 0, 0, get_theme_font_size("font_size")).x/2 
	$".".text = txt
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(true)
	tween.tween_property(self,  "modulate:a", 1, showTime/4)
	tween.set_parallel(false)
	tween.tween_property(self, "global_position:y", global_position.y, showTime/2)
	tween.set_parallel(true)
	tween.tween_property(self, "global_position:y", global_position.y-30, showTime/2)
	tween.tween_property(self,  "modulate:a", 0, showTime/2)
	await get_tree().create_timer(showTime).timeout
	queue_free()
	add_theme_font_size_override
