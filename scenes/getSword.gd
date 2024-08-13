extends Node2D

func _on_interactable_interacted():
	%Hero.grab_sword()
	queue_free()
