extends KinematicBody

var Blast = preload("res://scn/weapons/Blast.tscn")
var Laser = preload("res://scn/weapons/Laser.tscn")
var Rocket = preload("res://scn/weapons/Rocket.tscn")


func _ready():
    $"Timer_weapon_cooldown".wait_time = rand_range(2.0, 5.0)
    $"Timer_weapon_cooldown".start()
    $"Timer_rand_shoot".wait_time = rand_range(5.0, 10.0)
    $"Timer_rand_shoot".start()


func _process(delta):
    if $"Timer_weapon_cooldown".time_left == 0:
        if $"RayCast_player_1".is_colliding() or $"RayCast_player_2".is_colliding():
            shoot()


func choice(a):
    var r = randi() % a.size()
    return a[r]


func _on_Timer_rand_shoot_timeout():
    shoot()


func shoot():
    if not $"RayCast_front".is_colliding():
        $"Timer_weapon_cooldown".wait_time = rand_range(2.0, 5.0)
        $"Timer_weapon_cooldown".start()
        $"Timer_rand_shoot".wait_time = rand_range(5.0, 10.0)
        $"Timer_rand_shoot".start()

        var w = choice([
            Blast, Blast, Blast, Blast, Blast, Blast, Blast, Blast, Blast,
            Laser, Laser, Laser,
            Rocket
        ])

        var b = w.instance()
        b.speed *= -1
        b.translation = $"gun".global_transform.origin
        find_parent("Game").call_deferred("add_child", b)


func hit():
    queue_free()
