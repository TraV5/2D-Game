extends CharacterBody2D

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
