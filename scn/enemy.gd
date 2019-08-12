extends KinematicBody

var Blast = preload("res://scn/weapons/Blast.tscn")
var Laser = preload("res://scn/weapons/Laser.tscn")
var Rocket = preload("res://scn/weapons/Rocket.tscn")


func _ready():
    $"RayCast_front".force_raycast_update()
    if not $"RayCast_front".is_colliding():
        $"Timer_rand_shoot".wait_time = rand_range(5.0, 10.0)
        $"Timer_rand_shoot".start()

func _on_tree_exiting():
    find_parent("Wave")._on_enemy_tree_exiting()

    if $"RayCast_back".is_colliding():
        $"RayCast_back".get_collider()._on_front_unit_tree_exiting()

func _on_front_unit_tree_exiting():
    if not $"RayCast_front".is_colliding():
        $"Timer_rand_shoot".wait_time = rand_range(1.0, 10.0)
        $"Timer_rand_shoot".start()

func _on_Timer_rand_shoot_timeout():
    $"Timer_rand_shoot".wait_time = rand_range(1.0, 10.0)
    $"Timer_rand_shoot".start()

    var b = Blast.instance()
    b.speed *= -1
    b.translation = $"gun".global_transform.origin
    find_parent("Game").add_child(b)


func hit():
    queue_free()
