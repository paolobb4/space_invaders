extends Area


func _on_body_entered(body):
    body.queue_free()
    self.queue_free()
