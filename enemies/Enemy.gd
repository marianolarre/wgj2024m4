extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@export var speed: float = 64
@export var damage: int = 5
@onready var stun_timer = $StunTimer
@onready var sprite = $SpriteTransform/Sprite

const IDLE = 0
const CHASING = 1
var stunned = false
var state = 0
var hp:int = 100
var flash_tween

func _physics_process(delta):
	if stunned:
		velocity = velocity*0.95
	elif state == IDLE:
		animation_player.play("idle")
	elif state == CHASING:
		animation_player.play("walk")
		var direction = (%Hero.global_position-global_position).normalized()
		velocity = lerp(velocity, direction*speed, 0.2)
	move_and_slide()


func _on_area_2d_body_entered(body):
	state = CHASING


func _on_hurt_area_body_entered(body):
	%Hero.hurt(damage)


func hurt(damage, knockback):
	hp -= damage
	stun_timer.start(damage/10)
	velocity = knockback
	stunned = true
	animation_player.stop()
	animation_player.play("hit")
	if flash_tween != null:
		flash_tween.kill()
	flash_tween = get_tree().create_tween()
	sprite.self_modulate = Color.WHITE*10
	flash_tween.tween_property(sprite, "self_modulate", Color.WHITE, 0.2)
	if hp <= 0:
		queue_free()


func _on_stun_timer_timeout():
	stunned = false
