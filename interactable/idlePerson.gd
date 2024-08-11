extends Node2D

@onready var interactable = $Interactable

@export_multiline  var text: String = "Yo#Lorem Ipsum
Heroe#Ups
Dev#Consola
Dev#Probando probando"
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

@export_enum("Normal", "End Loop", "Die") var effect

func _ready():
	$AnimationPlayer.seek(randf_range(0.0, 2.0))

func _on_interactable_interacted():
	if effect == 1:
		DialogManager.finished_dialog.connect(_loop)
	elif effect == 2:
		DialogManager.finished_dialog.connect(_die_loop)
	DialogManager.start_dialog(self, text)
	audio_stream_player_2d.play()


func _loop():
	DialogManager.finished_dialog.disconnect(_loop)
	LoopManager.next_loop()


func _die_loop():
	%Hero.hurt(100)
	DialogManager.finished_dialog.disconnect(_loop)
	LoopManager.next_death_loops()
