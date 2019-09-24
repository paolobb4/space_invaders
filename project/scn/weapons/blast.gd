extends Area

export var speed = 1

var type = "blast"


func _process(delta):
    translation += Vector3(0,0,-1) * speed * delta


func _on_area_entered(area):
    if area.type == "blast":
        hit()
    if area.type == "laser":
        hit()
    if area.type == "rocket":
        hit()


func _on_body_entered(body):
    body.hit()
    self.hit()


func hit():
    queue_free()
