extends CanvasLayer

@onready var label = $NinePatchRect/Label
@onready var timer = $LetterDisplayTimer
@onready var letter_sound = $LetterSound
@onready var end_timer = $EndTimer
@onready var next_indicator = $NinePatchRect/Label/NextIndicator
@onready var message_sound = $MessageSound

const MAX_WIDTH = 256

var text = ""
var letter_index = 0
var letter_time = 0.015
var space_time = 0.02
var punctuation_time = 0.2
var end_time = 0.2
var last_sound = 0
var min_sound_delay = 0.06

signal finished_displaying()

func display_text(text_to_display: String):
	text = text_to_display
	next_indicator.hide()
	label.text = ""
	message_sound.play()
	_display_letter()

func _display_letter():
	label.text += text[letter_index]
	
	var time_seconds = Time.get_ticks_usec() / 1000000.0
	if time_seconds > last_sound+min_sound_delay:
		last_sound = time_seconds
		letter_sound.play()
	
	if letter_index >= text.length() - 1:
		end_timer.start(end_time)
		return
		
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
			
	letter_index += 1


func _on_letter_display_timer_timeout():
	_display_letter()


func _on_end_timer_timeout():
	next_indicator.show()
	finished_displaying.emit()
