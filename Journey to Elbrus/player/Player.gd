extends CharacterBody2D

var run_speed = 350
var jump_speed = -1000


func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('move_right')
	var left = Input.is_action_pressed('move_left')
	var jump = Input.is_action_just_pressed('jump')

	if is_on_floor() and jump:
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

func _physics_process(delta):
	get_input()
	move_and_slide()
#extends CharacterBody2D
#
#var speed = 30
#
#
#func _physics_process(delta: float):
#	var move_direction = Vector2.ZERO
#
#	if Input.is_action_pressed("move_left"):
#		move_direction.x = -1
#	elif Input.is_action_pressed("move_right"):
#		move_direction.x = 1
#
#	move_and_slide()
