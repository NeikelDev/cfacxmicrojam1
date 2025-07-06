extends Node2D

@onready var blood_sound: AudioStreamPlayer = $blood_sound
func _ready() -> void:
	blood_sound.play()
func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
