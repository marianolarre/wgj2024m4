extends Node2D

func _ready():
	$DeathParticles.emitting=true
	$DeathParticles2.emitting=true

func _on_timer_timeout():
	queue_free()
