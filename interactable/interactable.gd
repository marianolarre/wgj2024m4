extends Node2D

@onready var interact_indicator = $InteractIndicator


signal interacted()


func _ready():
	interact_indicator.hide()


func _on_area_2d_body_entered(body):
	interact_indicator.show()
	body.interacted.connect(_on_interacted)


func _on_area_2d_body_exited(body):
	interact_indicator.hide()
	body.interacted.disconnect(_on_interacted)


func _on_interacted():
	interact_indicator.hide()
	interacted.emit()
