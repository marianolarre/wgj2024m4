extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@export var speed: float = 128
@export var damage: int = 5
@onready var stun_timer = $StunTimer
@onready var hurt_timer = $HurtTimer
@onready var sprite = $SpriteTransform/Sprite

var hitting = false
const IDLE = 0
const CHASING = 1
var stunned = false
var state = 0
var hp:int = 100
var flash_tween
var random_offset
var direction


func _ready():
	random_offset = randf_range(0.0, 1.0)


func _physics_process(delta):
	if stunned:
		velocity = velocity*0.95
	elif state == IDLE:
		animation_player.play("idle")
	elif state == CHASING:
		var modulated_speed = 0
		var time_seconds = Time.get_ticks_usec() / 1000000.0
		if fmod(time_seconds+random_offset, 1) > 0.4:
			modulated_speed = speed
			animation_player.play("walk")
		else:
			animation_player.play("RESET")
			direction = (%Hero.global_position-global_position).normalized()
		if direction == null:
			direction = (%Hero.global_position-global_position).normalized()
		sprite.flip_h = direction.x > 0
		velocity = lerp(velocity, direction*modulated_speed, 0.4)
	move_and_slide()


func _on_area_2d_body_entered(body):
	state = CHASING


func _on_hurt_area_body_entered(body):
	hitting = true
	if hurt_timer.is_stopped():
		_hurt_hero()

func _on_hurt_area_body_exited(body):
	hitting = false


func hurt(damage, knockback):
	hp -= damage
	stun_timer.start(damage/10.0)
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


func _on_hurt_timer_timeout():
	if hitting:
		_hurt_hero()


func _hurt_hero():
	print(stunned)
	if not stunned:
		%Hero.hurt(damage)
		hurt_timer.start()
