extends Area

export var speed = 1


func _process(delta):
    translation += Vector3(0,0,-1) * speed * delta


func _on_Timer_timeout():
    self.queue_free()


func _on_area_entered(area):
    area.hit()
    self.queue_free()

func _on_body_entered(body):
    body.hit()
    self.queue_free()
