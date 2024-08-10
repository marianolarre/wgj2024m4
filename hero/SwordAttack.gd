extends Node2D


func _ready():
	$Sprite.global_position += Vector2(0, -50)
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite, "modulate", Color.TRANSPARENT, 0.2)
	tween.tween_callback($Sprite.queue_free)

func _process(delta):
	global_position += transform.x*delta*64

func _on_timer_timeout():
	queue_free()

func _on_area_2d_body_entered(body):
	body.hurt(10, transform.x*400 + Vector2(randf_range(-100, 100), randf_range(-100, 100)))
