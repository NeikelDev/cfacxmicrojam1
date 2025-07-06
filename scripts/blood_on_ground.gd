extends Node2D


func _on_blood_remover_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.lives += 30
		queue_free()
