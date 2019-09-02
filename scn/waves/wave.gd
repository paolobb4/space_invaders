extends Spatial
# State machine that controls enemy movements as a group.
# Possible states are: left, right, forward


export var initial_speed = 1.0
export var max_speed_factor = 1.0

onready var original_enemies_count = $"enemies".get_child_count()
onready var speed_increment = initial_speed * (max_speed_factor - 1 ) / original_enemies_count

var direction = "left"
var next_direction

func _ready():
    $"AnimationPlayer".play("spawn")

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

    var speed = initial_speed + (original_enemies_count - $"enemies".get_child_count()) * speed_increment

    $"AnimationPlayer".play("move_" + direction, -1, speed)

func _on_enemy_tree_exiting():
    print("enemy exiting tree")
    if $"enemies".get_child_count() == 1:
        print("Wave eliminated")
        queue_free()
