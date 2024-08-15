extends Area2D


@onready var static_body_2d = $StaticBody2D


func _on_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	static_body_2d.show()
	static_body_2d.process_mode = Node.PROCESS_MODE_ALWAYS
	%Hero.screen_shake(100)
	%Hero.boss_bar()
	$AudioStreamPlayer2D.play()
