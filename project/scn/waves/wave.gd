extends Spatial
# State machine that controls enemy movements as a group.
# Possible states are: left, right, forward

onready var bonus_scns = {
        "Speed": preload("res://scn/bonus/BonusSpeed.tscn"),
        "Shield": preload("res://scn/bonus/BonusShield.tscn"),
        "RegenWalls": preload("res://scn/bonus/BonusRegenWalls.tscn"),
        "DoubleShot": preload("res://scn/bonus/BonusDoubleShot.tscn"),
    }

export var initial_speed = 1.0
export var final_speed = 1.0

onready var original_enemies_count = $"wrapper/enemies".get_child_count()
onready var speed_increment = (final_speed - initial_speed) / original_enemies_count

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
    $"wrapper".translation += $"wrapper/enemies".translation
    $"wrapper/enemies".translation = Vector3()

    if animation_name == "move_forward":
        direction = next_direction

    var speed = initial_speed + (original_enemies_count - $"wrapper/enemies".get_child_count()) * speed_increment

    $"AnimationPlayer".play("move_" + direction, -1, speed)

func _on_enemy_tree_exiting():
    if $"wrapper/enemies".get_child_count() == 1:
        queue_free()


func spawnBonus(type, direction):
    var b = bonus_scns[type].instance()

    b.move(direction)

    match direction:
        'left':
            $"bonus_spawn_right".call_deferred("add_child", b)
        'right':
            $"bonus_spawn_left".call_deferred("add_child", b)
