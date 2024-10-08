extends Enemy


const SPEED = 200.0
const DISTANCE = 300.0
@onready var shoot_timer = $ShootTimer
@onready var slime_shot_scene = preload("res://enemies/SlimeShot.tscn")
@export var shooting_speed = 300
@export var spread = 0

func _physics_process(_delta):
	if stunned:
		velocity = velocity*0.95
		shoot_timer.start()
	elif state == IDLE or esperando:
		animation_player.play("idle")
	elif state == CHASING:
		if shoot_timer.time_left == 0:
			shoot_timer.start()
		var diff = (%Hero.global_position-global_position)
		var dist = diff.length()
		var direction = diff.normalized()
		if dist < DISTANCE:
			direction = -direction
		if dist < DISTANCE or dist > DISTANCE*1.2:
			animation_player.play(movement_animation)
			sprite.flip_h = direction.x < 0
		else:
			animation_player.play("idle")
			direction = Vector2(0,0)
		velocity = lerp(velocity, direction*speed, 0.2)
	move_and_slide()

func _on_shoot_timer_timeout():
	if not esperando:
		var dir = (%Hero.global_position-global_position).normalized()
		var attack = slime_shot_scene.instantiate()
		attack.global_position = global_position
		var rand_vec = Vector2(randf_range(-spread, spread), randf_range(-spread, spread))
		attack.set_velocity(dir*shooting_speed+rand_vec, damage)
		get_tree().root.add_child(attack)
