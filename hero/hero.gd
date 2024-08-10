class_name Hero extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var dialog_position = $DialogPosition
@onready var animation_player = $Sprite/AnimationPlayer
@onready var sprite = $Sprite
@onready var weapon_animation_player = $Weapon/WeaponAnimationPlayer
@onready var weapon = $Weapon

var talking = false
var attack_side = 1

signal interacted()


func _ready():
	print(LoopManager.loop)
	DialogManager.started_dialog.connect(_on_started_dialog)
	DialogManager.finished_dialog.connect(_on_finished_dialog)
	DialogManager.set_hero(self)


func _on_started_dialog():
	talking = true


func _on_finished_dialog():
	talking = false


func _physics_process(delta):
	if talking:
		return
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	if direction:
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
	if event.is_action_pressed("interact"):
		interacted.emit()
	if event.is_action_pressed("attack"):
		_attack()


func _attack():
	attack_side = -attack_side
	weapon.scale.y = attack_side
	weapon_animation_player.stop()
	weapon_animation_player.play("attack")
	LoopManager.next_loop()

