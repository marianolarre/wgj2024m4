extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var slime_vfx = preload("res://enemies/SlimeVFX.tscn")
var velocity
var damage

func set_velocity(vel, dmg):
	velocity = vel
	damage = dmg

func _physics_process(delta):
	if velocity:
		global_position += velocity*delta


func _on_timer_timeout():
	sprite_2d.frame = fmod(sprite_2d.frame+1, 2)


func _on_end_timer_timeout():
	var vfx = slime_vfx.instantiate()
	vfx.global_position = global_position + Vector2(0, -30)
	get_tree().root.add_child(vfx)
	queue_free()


func _on_body_entered(body):
	if body.name == "Hero":
		body.hurt(damage)
	var vfx = slime_vfx.instantiate()
	vfx.global_position = global_position + Vector2(0, -30)
	get_tree().root.add_child(vfx)
	queue_free()
