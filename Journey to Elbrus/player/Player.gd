extends CharacterBody2D

var run_speed = 150
var jump_speed = -200
var gravity = 300


@onready var animated_sprite := $AnimatedSprite2D

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('move_right')
	var left = Input.is_action_pressed('move_left')
	var jump = Input.is_action_just_pressed('jump')
	var land = Input.is_action_pressed("land")

	if is_on_floor() and jump:
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
		animated_sprite.flip_h = false
	if left:
		velocity.x -= run_speed
		animated_sprite.flip_h = true

func _physics_process(delta: float):
	velocity.y += gravity * delta
	
	get_input()
	_play_move_animation(velocity)
	move_and_slide()
	
func _play_move_animation(velocity: Vector2):
	if velocity.x != 0 and is_on_floor():
		animated_sprite.play("run")
	elif velocity.x == 0 and is_on_floor():
		animated_sprite.play("idle")
	elif velocity.y <= 0:
		animated_sprite.play("jump")
	elif velocity.y > 0:
		animated_sprite.play("fall")
