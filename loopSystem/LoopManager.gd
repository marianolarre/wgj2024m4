extends Node
var loop = 1


func next_loop():
	loop += 1
	get_tree().reload_current_scene()
