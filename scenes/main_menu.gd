extends CanvasLayer
@onready var animation_player = $Background/AnimationPlayer
@onready var sfx = $SFX

var stage = 1
func _input(event):
	if animation_player.is_playing():
		return
	if (event.is_action_pressed("interact")):
		if stage == 1:
			stage = 2
			sfx.play()
			animation_player.play("select_character")
		else:
			sfx.play()
			animation_player.play("go_to_game")

func go_to_game():
	get_tree().change_scene_to_file("res://scenes/world.tscn")
