extends Area2D
class_name Arrow

# boolean stats
var inGame = false
var atacking = false

# Stats
var damage = 10.0
var atk_codown = 1.0
var atk_speed = 900


func _physics_process(delta: float) -> void:
	position += transform.x * atk_speed * delta
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		area.queue_free()
	queue_free()
	pass # Replace with function body.
