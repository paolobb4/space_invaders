extends KinematicBody

var Blast = preload("res://scn/weapons/Blast.tscn")
var Laser = preload("res://scn/weapons/Laser.tscn")
var Rocket = preload("res://scn/weapons/Rocket.tscn")

export var weapon_cooldown_min = 2.0
export var weapon_cooldown_max = 5.0
export var random_shoot_min = 2.0
export var random_shoot_max = 10.0
export var shoot_probability = 0.5
export var hit_points = 1


func _ready():
    if (weapon_cooldown_min and weapon_cooldown_max):
        $"Timer_weapon_cooldown".wait_time = rand_range(weapon_cooldown_min, weapon_cooldown_max)
        $"Timer_weapon_cooldown".start()
    if (random_shoot_min and random_shoot_max):
        $"Timer_rand_shoot".wait_time = rand_range(random_shoot_min, random_shoot_max)
        $"Timer_rand_shoot".start()


func _process(delta):
    if $"Timer_weapon_cooldown".time_left == 0:
        if $"RayCast_player".is_colliding():
            if (randf() < shoot_probability):
                shoot()


func choice(a):
    var r = randi() % a.size()
    return a[r]


func _on_Timer_rand_shoot_timeout():
    shoot()


func shoot():
    if not $"RayCast_front".is_colliding():
        if (weapon_cooldown_min and weapon_cooldown_max):
            $"Timer_weapon_cooldown".wait_time = rand_range(weapon_cooldown_min, weapon_cooldown_max)
            $"Timer_weapon_cooldown".start()
        if (random_shoot_min and random_shoot_max):
            $"Timer_rand_shoot".wait_time = rand_range(random_shoot_min, random_shoot_max)
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
    hit_points -= 1
    if hit_points == 0:
        queue_free()


func _on_tree_exiting():
    find_parent("Wave")._on_enemy_tree_exiting()
