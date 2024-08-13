extends Node2D

@onready var label = $Interactable/Label

var wood = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	%Hero.got_wood.connect(increment)
	
func increment():
	wood += 1
	label.text = str(wood,"/20")

func _on_interactable_interacted():
	if wood >= 20:
		DialogManager.finished_dialog.connect(_loop)
		DialogManager.start_dialog(self, "Dev#20 de madera, por favor. Como puede pensar alguien que con eso se construye una casa. Mecánica borrada, chau.
Dev#> reiniciar_juego")
	else:
		DialogManager.start_dialog(self, "Yo#Necesitas más madera")

func _loop():
	DialogManager.finished_dialog.disconnect(_loop)
	LoopManager.next_loop()
