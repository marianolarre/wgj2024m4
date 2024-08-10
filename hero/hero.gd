class_name Hero extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var dialog_position = $DialogPosition
@onready var animation_player = $Sprite/AnimationPlayer
@onready var sprite = $Sprite
@onready var weapon_animation_player = $Weapon/WeaponAnimationPlayer
@onready var weapon = $Weapon
@onready var health_bar = %HealthBar
@onready var death_timer = $Death
@onready var ui = %UI

const SWORD_ATTACK = preload("res://hero/SwordAttack.tscn")

var hp: int = 100
var dying = false

var talking = false
var attack_side = 1
var direction
var facing

signal interacted()


func _ready():
	DialogManager.started_dialog.connect(_on_started_dialog)
	DialogManager.finished_dialog.connect(_on_finished_dialog)
	DialogManager.set_hero(self)
	facing = Vector2(1, 0)
	ui.set_hp(100)
	ui.fade_in()


func _on_started_dialog():
	talking = true
	animation_player.play("idle")


func _on_finished_dialog():
	talking = false


func _physics_process(delta):
	if talking or dying:
		return
	direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	if direction:
		facing = direction.normalized()
		animation_player.play("move")
		weapon.rotation = atan2(direction.y, direction.x)
		if abs(direction.x) > abs(direction.y):
			sprite.frame = 1
			sprite.flip_h = sign(direction.x) == -1
		else:
			sprite.flip_h = false
			if direction.y > 0:
				sprite.frame = 0
			else:
				sprite.frame = 2
	else:
		animation_player.play("idle")
	direction = direction.normalized()
	velocity = direction * SPEED
	move_and_slide()


func _unhandled_input(event):
	if dying:
		return
	if event.is_action_pressed("interact"):
		interacted.emit()
	if event.is_action_pressed("attack"):
		if not talking:
			_attack()


func _attack():
	attack_side = -attack_side
	weapon.scale.y = attack_side
	weapon_animation_player.stop()
	weapon_animation_player.play("attack")
	var attack = SWORD_ATTACK.instantiate()
	attack.global_position = global_position + facing*128
	attack.rotation = atan2(facing.y, facing.x)
	attack.scale.y = -attack_side
	get_tree().root.add_child(attack)


func hurt(damage):
	hp -= clamp(damage, 0, 100)
	ui.set_hp(hp)
	if hp <= 0 and not dying:
		animation_player.stop()
		animation_player.play("death")
		sprite.frame = 3
		dying = true
		death_timer.start()


func _on_death_timeout():
	ui.fade_out(LoopManager.repeat_loop)
