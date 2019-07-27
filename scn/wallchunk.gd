extends StaticBody

func hit():
    queue_free()

func _on_enemy_detector_body_entered(body):
    hit()
