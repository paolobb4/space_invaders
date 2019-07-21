extends Spatial
# State machine that controls enemy movements as a group.
# Possible states are: left, right, forward


export var speed = 1

var direction = "left"
var next_direction


func _ready():
    $"AnimationPlayer".play("move_" + direction)

func _on_limit_left_hit(a):
    direction = "forward"
    next_direction = "right"

func _on_limit_right_hit(a):
    direction = "forward"
    next_direction = "left"

func _on_animation_finished(animation_name):
    self.translation += $"enemies".translation
    $"enemies".translation = Vector3()

    if animation_name == "move_forward":
        direction = next_direction

    $"AnimationPlayer".play("move_" + direction)
