extends Node2D

@onready var pre_sword = $PreSword
@onready var post_sword = $PostSword

func _ready():
	post_sword.hide()
	post_sword.process_mode = 4


func _on_interactable_interacted():
	%Hero.grab_sword()
	post_sword.show()
	post_sword.process_mode = 0
	pre_sword.hide()
	pre_sword.process_mode = 4
