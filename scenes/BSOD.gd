extends Area2D

@onready var timer = $Timer


func _on_body_entered(_body):
	%Hero.blue_screen()
	timer.start()


func _on_timer_timeout():
	DialogManager.finished_dialog.connect(_loop)
	DialogManager.start_dialog(self, "Dev#¡Lo único que me falta es que se me prenda fuego la computadora y pierda todo el proyecto por un guerrero mediocre!
Dev#Nota: Por seguridad. Comprar más memoria para la PC.")

func _loop():
	DialogManager.finished_dialog.disconnect(_loop)
	LoopManager.next_loop()
