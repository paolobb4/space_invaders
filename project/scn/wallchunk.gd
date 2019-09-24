extends StaticBody


var dead = false


func _ready():
    $"AnimationPlayer".play("spawn")

func hit():
    $"..".disable_wall_chunk(self)

func _on_enemy_detector_body_entered(body):
    hit()
