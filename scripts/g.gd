extends Node

var newEnding: bool = false
var endings: Array = [0,0,0,0,0]

func giveEnding(ending):
	newEnding = true
	endings[ending] = 1

func spawnText(text: String, pos: Vector2 = Vector2(0, 0), showTime = 1, font_size: int = 22):
	var newText = load("res://scenes/spawntext.tscn").instantiate()
	get_parent().get_child(-1).add_child(newText)
	newText.set("theme_override_font_sizes/font_size", font_size)
	newText.global_position = pos
	newText.animate(text, showTime)
