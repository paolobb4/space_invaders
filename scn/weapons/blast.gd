extends Area

export var speed = 1


var type = "blast"


func _process(delta):
    translation += Vector3(0,0,-1) * speed * delta


func _on_Timer_timeout():
    self.queue_free()


func _on_area_entered(area):
    if area.type == "blast":
        queue_free()
    if area.type == "laser":
        queue_free()
    if area.type == "rocket":
        queue_free()


func _on_body_entered(body):
    body.hit()
    self.queue_free()
