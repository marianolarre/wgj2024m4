extends CanvasLayer

@onready var health_bar = $HealthBarContainer/HealthBar
@onready var fade_to_black = $FadeToBlack
@onready var damage_overlay = $DamageOverlay
@onready var pantalla_azul = $PantallaAzul


func _ready():
	show()
	fade_to_black.show()
	damage_overlay.show()

func set_hp(hp):
	health_bar.value = hp

func fade_in():
	fade_to_black.color = Color.from_string("#202329", Color.BLACK)
	var tween = get_tree().create_tween()
	tween.tween_property(fade_to_black, "color", Color.from_string("#20232900", Color.BLACK), 0.5)

func fade_out(callback):
	fade_to_black.color = Color.from_string("#20232900", Color.BLACK)
	var tween = get_tree().create_tween()
	tween.tween_property(fade_to_black, "color", Color.from_string("#202329", Color.BLACK), 0.5)
	tween.tween_callback(callback)

func hurt_overlay():
	damage_overlay.color = Color.from_string("#ff000040", Color.RED)
	var tween = get_tree().create_tween()
	tween.tween_property(damage_overlay, "color", Color.from_string("#ff000000", Color.TRANSPARENT), 0.2)


func blue_screen():
	pantalla_azul.show()

func boss_bar():
	$BossHPBar.show()
