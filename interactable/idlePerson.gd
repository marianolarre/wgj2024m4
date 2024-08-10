extends Node2D

@onready var interactable = $Interactable

@export var lines: Array[String] = [
	"Hero#Hola!",
	"Hero#Esto es una prueba de texto.",
	"Me#Frena en los puntos. Tambien en las comas, mira.",
	"Hero#Hohooo ho"
]

func _on_interactable_interacted():
	DialogManager.start_dialog(self, lines)
