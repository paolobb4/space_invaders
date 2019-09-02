extends Spatial

var Wall = preload("res://scn//Wall.tscn")

var waves = [
        preload("res://scn/waves/Wave_1.tscn"),
        preload("res://scn/waves/Wave_2.tscn"),
        preload("res://scn/waves/Wave_3.tscn"),
]
var current_wave = -1

onready var cameras = [
    get_node("Perspective_cam"),
    get_node("Orthogonal_cam"),
    get_node("Orthogonal_cam2"),
]

var current_camera = 0

func _ready():
    cameras[current_camera].make_current()
    next_wave()

func _process(delta):
    if Input.is_action_just_pressed("change_camera"):
        current_camera = (current_camera + 1) % cameras.size()
        cameras[current_camera].make_current()


func next_wave():
    current_wave = (current_wave + 1) % waves.size()

    var new_wave = waves[current_wave].instance()

    $"Wave origin".call_deferred("add_child", new_wave)

    $"world limits/enemies limit left".connect("body_entered", new_wave, "_on_limit_left_hit")
    $"world limits/enemies limit right".connect("body_entered", new_wave, "_on_limit_right_hit")

    new_wave.connect("tree_exited", self, "next_wave")

    regenWalls()


func regenWalls():
    for wall in $"walls".get_children():
        wall.regenerate()


func on_projectile_limit_hit(projectile):
    projectile.queue_free()


func _on_bonus_limit_hit(bonus):
    bonus._on_limit_wall_hit()
