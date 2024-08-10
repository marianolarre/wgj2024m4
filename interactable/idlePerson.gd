extends Node2D

@onready var interactable = $Interactable

@export var lines: Array[String] = [
	"Hero#Hola!",
	"Hero#Esto es una prueba de texto.",
	"Me#Frena en los puntos. Tambien en las comas, mira.",
	"Hero#Hohooo ho"
]


func _ready():
	$AnimationPlayer.seek(randf_range(0.0, 2.0))


func _on_interactable_interacted():
	DialogManager.start_dialog(self, lines)
