extends KinematicBody

export(String) var type

func hit():
    find_parent("Game").find_node("Player")._on_bonus_hit(self.type)
    queue_free()
