extends Enemy

var random_offset
var direction

func _ready():
	random_offset = randf_range(0.0, 1.0)
	DialogManager.started_dialog.connect(_cortesia_start)
	DialogManager.finished_dialog.connect(_cortesia_end)

func _physics_process(_delta):
	if stunned:
		velocity = velocity*0.95
	elif state == IDLE or esperando:
		animation_player.play("idle")
	elif state == CHASING:
		var modulated_speed = 0
		var time_seconds = Time.get_ticks_usec() / 1000000.0
		if fmod(time_seconds+random_offset, 1) > 0.4:
			modulated_speed = speed
			animation_player.play("walk")
		else:
			animation_player.play("RESET")
			direction = (%Hero.global_position-global_position).normalized()
		if direction == null:
			direction = (%Hero.global_position-global_position).normalized()
		sprite.flip_h = direction.x > 0
		velocity = lerp(velocity, direction*modulated_speed, 0.4)
	move_and_slide()
