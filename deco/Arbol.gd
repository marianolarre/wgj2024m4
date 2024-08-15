extends StaticBody2D

var hp = 3
@onready var sprite_2d = $Sprite2D
const TREE_1_CUT = preload("res://arbol/Tree1cut.png")
@onready var wood_item_scene = preload("res://interactable/WoodItem.tscn")

func _ready():
	if LoopManager.loop == 5:
		set_collision_layer_value(7, true)

func hurt(_dmg, _knockback):
	hp -= 1
	$DeathParticles.emitting = true
	$AudioStreamPlayer2D.play()
	if hp <= 0:
		sprite_2d.texture = TREE_1_CUT
		set_collision_layer_value(7, false)
		for n in 3:
			var item = wood_item_scene.instantiate()
			item.global_position = global_position
			get_tree().root.add_child(item)
