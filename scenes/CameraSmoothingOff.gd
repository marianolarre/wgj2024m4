extends Area2D

func _on_body_entered(body):
	if body is Hero:
		set_deferred("monitoring", false)
		body.disable_smoothing()
