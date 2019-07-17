extends KinematicBody

export var speed = 1


func _process(delta):
    move_and_collide(Vector3(0,0,-1) * speed * delta)
