extends CanvasLayer

@onready var health_bar = $HealthBar
@onready var fade_to_black = $FadeToBlack

func set_hp(hp):
	health_bar.value = hp

func fade_in():
	fade_to_black.color = Color.from_string("#202329", Color.BLACK)
	var tween = get_tree().create_tween()
	tween.tween_property(fade_to_black, "color", Color.from_string("#20232900", Color.BLACK), 1)

func fade_out(callback):
	fade_to_black.color = Color.from_string("#20232900", Color.BLACK)
	var tween = get_tree().create_tween()
	tween.tween_property(fade_to_black, "color", Color.from_string("#202329", Color.BLACK), 1)
	tween.tween_callback(callback).set_delay(1)
