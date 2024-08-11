extends Node2D

@onready var interactable = $Interactable

@export_multiline  var text: String = "Yo#Lorem Ipsum
Heroe#Ups
Dev#Consola
Dev#Probando probando"

func _ready():
	$AnimationPlayer.seek(randf_range(0.0, 2.0))

func _on_interactable_interacted():
	DialogManager.start_dialog(self, text)
