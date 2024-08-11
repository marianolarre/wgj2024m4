extends Node2D

@onready var target_position = $TargetPosition

func _on_interactable_interacted():
	%Hero.teleport(target_position.global_position)
