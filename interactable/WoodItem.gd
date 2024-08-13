extends RigidBody2D

const SPD = 600

func _ready():
	linear_velocity = Vector2(randf_range(-SPD, SPD), randf_range(-SPD, SPD))


func _on_timer_timeout():
	set_collision_layer_value(8, true)
	linear_velocity = Vector2.ZERO
