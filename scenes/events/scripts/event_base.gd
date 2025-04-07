extends Sprite2D
class_name event

var main
var chosen: bool = false

@export var doOpenDoors: bool = true
@export var canLeave: bool = true

func onStart():
	pass

func _ready() -> void:
	main = get_parent().get_parent()
	$CanvasLayer/CanvasGroup.modulate[3] = 0
	$CanvasLayer.visible = false
	onStart()

func showText(obj = $CanvasLayer/CanvasGroup):
	obj.get_parent().visible = true
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(true)
	tween.tween_property(obj, "modulate:a", 1, 2)

func hideText(obj = $CanvasLayer/CanvasGroup):
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(true)
	tween.tween_property(obj, "modulate:a", 0, 2)
	await get_tree().create_timer(2).timeout
	obj.get_parent().visible = false
