extends Node

@onready var text_box_scene = preload("res://dialogSystem/textbox.tscn")
@onready var console_box_scene = preload("res://dialogSystem/consolebox.tscn")
@onready var npc_text_box_scene = preload("res://dialogSystem/npctextbox.tscn")
@onready var avatar_text_box_scene = preload("res://dialogSystem/avatartextbox.tscn")

var dialog_lines
var current_line_index = 0

var created_box
var text_box_position: Vector2

var is_dialog_active = false
var can_advance_line = false
var speaker: Node2D
var hero: Hero

signal started_dialog()
signal finished_dialog()

func start_dialog(new_speaker: Node2D, text:String):
	if is_dialog_active:
		return
	
	speaker = new_speaker
	dialog_lines = text.split("\n")
	_show_text_box()
	
	is_dialog_active = true
	started_dialog.emit()


func set_hero(new_hero: Hero):
	hero = new_hero


func _show_text_box():
	var split = dialog_lines[current_line_index].split("#")
	var speaker_name = split[0]
	if speaker_name == "Dev":
		created_box = console_box_scene.instantiate()
		created_box.finished_displaying.connect(_on_text_box_finished_displaying)
		get_tree().root.add_child(created_box)
		created_box.display_text(split[1])
	else:
		if speaker_name == "Yo":
			created_box = npc_text_box_scene.instantiate()
			text_box_position = speaker.get_node("DialogPosition").global_position
		elif speaker_name == "Heroe":
			created_box = text_box_scene.instantiate()
			text_box_position = hero.get_node("DialogPosition").global_position
		elif speaker_name == "Avatar":
			created_box = avatar_text_box_scene.instantiate()
			text_box_position = speaker.get_node("DialogPosition").global_position
		created_box.finished_displaying.connect(_on_text_box_finished_displaying)
		get_tree().root.add_child(created_box)
		created_box.global_position = text_box_position+Vector2(-16, -64) # Numeros magicos!
		created_box.display_text(split[1])
	can_advance_line = false


func _on_text_box_finished_displaying():
	can_advance_line = true


func _unhandled_input(event):
	if event.is_action_pressed("advance_dialog") and is_dialog_active and can_advance_line:
		created_box.queue_free()
		
		current_line_index += 1
		
		if current_line_index >= dialog_lines.size() or dialog_lines[current_line_index] == "":
			is_dialog_active = false
			current_line_index = 0
			finished_dialog.emit()
			return
		
		_show_text_box()
