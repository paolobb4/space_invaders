extends KinematicBody

export(String) var type
export(int) var speed = 6.8

var direction = 0


func _process(delta):
    self.translation += Vector3(direction, 0, 0) * speed * delta


func move(direction):
    match direction:
        'left':
            self.direction = -1
        'right':
            self.direction = 1
        _:
            push_error("Key error: unsuported direction '" + direction + "'")


func hit():
    find_parent("Game").find_node("Player")._on_bonus_hit(self.type)
    queue_free()


func _on_limit_wall_hit():
    queue_free()
