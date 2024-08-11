class_name Enemy extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@export var speed: float = 64
@export var damage: int = 5
@export var knockback_multiplier: float = 1
@onready var stun_timer = $StunTimer
@onready var hurt_timer = $HurtTimer
@onready var sprite = $SpriteTransform/Sprite
@export var movement_animation: String = "walk"
@onready var death_particles = $SpriteTransform/Sprite/DeathParticles
@onready var death_vfx = preload("res://enemies/DeathVFX.tscn")

var hitting = false
const IDLE = 0
const CHASING = 1
var stunned = false
var state = 0
@export var hp:int = 40
var flash_tween
var esperando = false

func _ready():
	DialogManager.started_dialog.connect(_cortesia_start)
	DialogManager.finished_dialog.connect(_cortesia_end)


func _cortesia_start():
	esperando = true
	velocity = Vector2(0,0)

func _cortesia_end():
	esperando = false


func _physics_process(_delta):
	if stunned:
		velocity = velocity*0.95
	elif state == IDLE or esperando:
		animation_player.play("idle")
	elif state == CHASING:
		animation_player.play(movement_animation)
		var direction = (%Hero.global_position-global_position).normalized()
		sprite.flip_h = direction.x < 0
		velocity = lerp(velocity, direction*speed, 0.2)
	move_and_slide()


func _on_area_2d_body_entered(_body):
	state = CHASING


func _on_hurt_area_body_entered(_body):
	hitting = true
	if hurt_timer.is_stopped():
		_hurt_hero()

func _on_hurt_area_body_exited(_body):
	hitting = false

func hurt(dmg, knockback):
	hp -= dmg
	stun_timer.start(dmg/20.0*knockback_multiplier)
	velocity = knockback*knockback_multiplier*knockback_multiplier
	stunned = true
	animation_player.stop()
	animation_player.play("hit")
	if flash_tween != null:
		flash_tween.kill()
	flash_tween = get_tree().create_tween()
	sprite.self_modulate = Color.WHITE*10
	flash_tween.tween_property(sprite, "self_modulate", Color.WHITE, 0.2)
	death_particles.emitting = true
	if hp <= 0:
		var vfx = death_vfx.instantiate()
		vfx.global_position = global_position
		get_tree().root.add_child(vfx)
		queue_free()


func _on_stun_timer_timeout():
	stunned = false


func _on_hurt_timer_timeout():
	if hitting:
		_hurt_hero()


func _hurt_hero():
	if not stunned and not esperando:
		%Hero.hurt(damage)
		hurt_timer.start()
