extends TextureRect

@export var item: String

func _ready() -> void:
	$Sprite2D.texture = texture

func _on_button_pressed() -> void:
	get_parent().get_parent().get_parent().removeItem(self)

func _on_color_rect_mouse_entered() -> void:
	$Sprite2D.scale = Vector2(1.1,1.1)
	$Button.visible = true

func _on_color_rect_mouse_exited() -> void:
	$Sprite2D.scale = Vector2(1,1)
	$Button.visible = false
	
func _on_button_mouse_entered() -> void:
	$Button.visible = true

func _on_button_mouse_exited() -> void:
	$Button.visible = false
