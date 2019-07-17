extends KinematicBody

export var speed = 1    # unit per seccond


func _process(delta):
    var move = 0

    if Input.is_action_pressed("move_left"):
        move -= 1
    if Input.is_action_pressed("move_right"):
        move += 1


    move_and_collide(Vector3(1,0,0) * move * speed * delta)
