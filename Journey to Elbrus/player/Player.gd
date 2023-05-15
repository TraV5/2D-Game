extends CharacterBody2D

signal hp_changed

const IMMORTAL_TIME = 2

var run_speed = 150
const jump_speed = -200
var gravity = 300
var hp = 8
var immortal_time = 0.0


@onready var animated_sprite := $AnimatedSprite2D
@onready var ray_cast_down := $RayCastDown
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	call_deferred("change_hp", 0)
	_play_animation("idle")

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
	if land:
		velocity.y += 15
	if not is_on_floor() and velocity.y > 0 and ray_cast_down.is_colliding():
		var enemy = ray_cast_down.get_collider()
		hit_enemy(enemy)
		
func _physics_process(delta: float):
	
	velocity.y += gravity * delta
	
	get_input()
	
	_play_move_animation(velocity)
	move_and_slide()
	
	if immortal_time >= 0:
		immortal_time -= delta
		animation_player.play("Immortal")
	else:
		animation_player.stop()
	
func _play_move_animation(velocity: Vector2):
	if velocity.x != 0 and is_on_floor():
		animated_sprite.play("run")
	elif velocity.x == 0 and is_on_floor():
		animated_sprite.play("idle")
	elif velocity.y <= 0:
		animated_sprite.play("jump")
	elif velocity.y > 0:
		animated_sprite.play("fall")
		
func _play_animation(animation: String):
	if animated_sprite.animation != animation:
		animated_sprite.play(animation)

func hit_enemy(enemy: Node2D):
	if enemy.has_method("die"):
		enemy.die()
	velocity.y = jump_speed / 2.0

func take_damage(damage: int, attack_direction: Vector2):
	change_hp(-damage)
	immortal_time = IMMORTAL_TIME
	
func change_hp(diff: int):
	hp += diff
	emit_signal("hp_changed", hp)
