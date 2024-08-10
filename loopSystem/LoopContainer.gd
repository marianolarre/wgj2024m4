class_name LoopContainer extends Node2D

@export var loopNumber: int

func _ready():
	if LoopManager.loop == loopNumber:
		self.show()
	else:
		self.queue_free()
