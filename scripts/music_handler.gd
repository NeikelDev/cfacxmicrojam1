extends Node
@onready var intro: AudioStreamPlayer = $intro
@onready var main_music: AudioStreamPlayer = $main_music




func _on_intro_finished() -> void:
	main_music.play()
