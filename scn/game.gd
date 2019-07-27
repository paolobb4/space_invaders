extends Spatial

onready var cameras = [
    get_node("Perspective_cam2"),
    get_node("Orthogonal_cam"),
]

var current_camera = 0

func _ready():
    cameras[current_camera].make_current()

func _process(delta):
    if Input.is_action_just_pressed("change_camera"):
        current_camera = (current_camera + 1) % cameras.size()
        cameras[current_camera].make_current()
