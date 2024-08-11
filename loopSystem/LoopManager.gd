extends Node
var loop = 1
var scripted_death = false

func next_loop():
	loop += 1
	scripted_death = false
	get_tree().reload_current_scene()


func repeat_loop():
	if scripted_death:
		loop += 1
		scripted_death = false
	get_tree().reload_current_scene()


func next_death_loops():
	scripted_death = true
