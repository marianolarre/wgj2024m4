extends Area2D

@export var offset:Vector2

func _on_body_entered(body):
	if body is Hero:
		body.seamless_teleport(offset)
