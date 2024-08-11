extends Area2D


@export_multiline var text: String = "Heroe#Ups
Dev#Consola
Dev#Probando probando"


func _on_body_entered(body):
	DialogManager.finished_dialog.connect(_loop)
	DialogManager.start_dialog(self, text)


func _loop():
	DialogManager.finished_dialog.disconnect(_loop)
	LoopManager.next_loop()
