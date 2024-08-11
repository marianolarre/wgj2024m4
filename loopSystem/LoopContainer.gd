class_name LoopContainer extends Node2D

@export var loopNumber: int
@export_enum("=", ">=", "<=", "!=", "()", ")(") var condition
@export var loopNumberRange: int

func _ready():
	if condition == 0 and LoopManager.loop == loopNumber:
		self.show()
	elif condition == 1 and LoopManager.loop >= loopNumber:
		self.show()
	elif condition == 2 and LoopManager.loop <= loopNumber:
		self.show()
	elif condition == 3 and LoopManager.loop != loopNumber:
		self.show()
	elif condition == 4 and LoopManager.loop >= loopNumber and LoopManager.loop <= loopNumberRange:
		self.show()
	elif condition == 5 and (LoopManager.loop < loopNumber or LoopManager.loop > loopNumberRange):
		self.show()
	else:
		self.queue_free()
