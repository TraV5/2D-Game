extends CharacterBody2D

@export var damage := 1
var gravity = 300


@onready var animated_sprite := $AnimatedSprite2D

func _ready() ->void:
	_play_animation("idle")
	pass	
	
func _play_animation(animation: String):
	if animated_sprite.animation != animation:
		animated_sprite.play(animation)
		
func die():
	_play_animation("death")
	$CollisionShape2D.set_deferred("disabled", true)
	
func attack(player: CharacterBody2D):
	player.take_damage(damage, global_position.direction_to(player.global_position))
