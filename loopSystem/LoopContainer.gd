class_name LoopContainer extends Node2D

@export var loopNumber: int
@export_enum("=", ">=", "<=", "!=", "()", ")(") var condition
@export var loopNumberRange: int
var spawnpoint
@export_multiline var startDialog: String
@export var deathIsScripted: bool

func _ready():
	if (get_node_or_null("Spawnpoint")):
		spawnpoint = $Spawnpoint
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
		return
	if spawnpoint:
		%Hero.global_position = spawnpoint.global_position
	if deathIsScripted:
		LoopManager.next_death_loops()
	if startDialog and startDialog != "":
		DialogManager.start_dialog(self, startDialog)
