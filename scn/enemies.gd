extends Spatial
# State machine that controls enemy movements as a group.
# Possible states are: left, right, forward


export var speed = 1

var last_state = "right"
var state = "right"

func _process(delta):
    var move = Vector3()

    match state:
        "left":
            translation.x -= speed * delta
        "right":
            translation.x += speed * delta
        "forward":
            pass


func _on_limit_left_hit(a):
    state = "right"

func _on_limit_right_hit(a):
    state = "left"
