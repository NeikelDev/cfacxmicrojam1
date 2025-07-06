extends Node2D


func _on_blood_remover_timeout() -> void:
	queue_free()
