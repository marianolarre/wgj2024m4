class_name Hero extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var dialog_position = $DialogPosition
@onready var animation_player = $Sprite/AnimationPlayer
@onready var sprite = $Sprite

var talking = false

signal interacted()


func _ready():
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
		if direction.x != 0:
			sprite.flip_h = sign(direction.x) == -1
	else:
		animation_player.play("idle")
	direction = direction.normalized()
	velocity = direction * SPEED
	move_and_slide()


func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		interacted.emit()
