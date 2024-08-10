extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var dialog_position = $DialogPosition

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var talking = false

const test_lines: Array[String] = [
	"Hola!",
	"Esto es una prueba de texto.",
	"Frena en los puntos. Tambien en las comas, mira.",
	"Hohooo ho"
]


func _ready():
	DialogManager.started_dialog.connect(_on_started_dialog)
	DialogManager.finished_dialog.connect(_on_finished_dialog)


func _on_started_dialog():
	talking = true


func _on_finished_dialog():
	talking = false


func _physics_process(delta):
	if talking:
		return
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	direction = direction.normalized()
	velocity = direction * SPEED
	move_and_slide()


func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		DialogManager.start_dialog(dialog_position.global_position, test_lines)
		talking = true
