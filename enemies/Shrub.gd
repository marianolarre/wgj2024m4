extends StaticBody2D

const BUSH_DEATH_VFX = preload("res://enemies/BushDeathVFX.tscn")

func hurt(_damage, _knockback):
	var vfx = BUSH_DEATH_VFX.instantiate()
	vfx.global_position = global_position
	get_tree().root.add_child(vfx)
	queue_free()
