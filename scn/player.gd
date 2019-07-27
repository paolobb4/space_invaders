extends KinematicBody

var Bullet = preload("res://scn/Bullet.tscn")

export var speed = 1    # unit per seccond


func _process(delta):
    var move = 0

    if Input.is_action_pressed("move_left"):
        move -= 1
    if Input.is_action_pressed("move_right"):
        move += 1

    if Input.is_action_just_pressed("shoot"):
        if ($"cooldown".time_left <= 0):
            $"cooldown".start()
            var b = Bullet.instance()
            b.translation = $"gun".global_transform.origin
            find_parent("Game").add_child(b)


    move_and_collide(Vector3(1,0,0) * move * speed * delta)


func hit():
    queue_free()
