tool
extends KinematicBody

var Blast = preload("res://scn/weapons/Blast.tscn")
var Laser = preload("res://scn/weapons/Laser.tscn")
var Rocket = preload("res://scn/weapons/Rocket.tscn")

export(float) var weapon_cooldown_min = 2.0
export(float) var weapon_cooldown_max = 5.0
export(float) var random_shoot_min = 5.0
export(float) var random_shoot_max = 10.0
export(float) var shoot_probability = 0.5
export(int) var hit_points = 1
export(Color, RGB) var mask_color = Color("cc0504") setget set_mask_color 
export(Color, RGB) var body_color = Color("2b6321") setget set_body_color 
export(Color, RGB) var details_color = Color("db710a") setget set_details_color 

onready var raycast_shoot_active = (weapon_cooldown_min and weapon_cooldown_max)
onready var random_shoot_active = (random_shoot_min and random_shoot_max)
onready var in_editor = Engine.editor_hint


func _ready():
    if (not in_editor):
        if raycast_shoot_active:
            $"Timer_weapon_cooldown".wait_time = rand_range(weapon_cooldown_min, weapon_cooldown_max)
            $"Timer_weapon_cooldown".start()
        if random_shoot_active :
            $"Timer_rand_shoot".wait_time = rand_range(random_shoot_min, random_shoot_max)
            $"Timer_rand_shoot".start()
    else:
        set_process(false)


func _process(delta):
    if raycast_shoot_active and $"Timer_weapon_cooldown".time_left == 0:
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
        if raycast_shoot_active:
            $"Timer_weapon_cooldown".wait_time = rand_range(weapon_cooldown_min, weapon_cooldown_max)
            $"Timer_weapon_cooldown".start()
        if random_shoot_active :
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

### TOOL

func set_body_color(value):
    body_color = Color(value)

    var material = $"Mesh".get_surface_material(0)
    if (not material):
        material = $"Mesh".mesh.surface_get_material(0).duplicate()
        $"Mesh".set_surface_material(0, material)
    material.albedo_color = Color(value)

func set_mask_color(value):
    mask_color = Color(value)

    var material = $"Mesh".get_surface_material(1)
    if (not material):
        material = $"Mesh".mesh.surface_get_material(1).duplicate()
        $"Mesh".set_surface_material(1, material)
    material.albedo_color = Color(value)

func set_details_color(value):
    details_color = Color(value)

    var material = $"Mesh".get_surface_material(2)
    if (not material):
        material = $"Mesh".mesh.surface_get_material(2).duplicate()
        $"Mesh".set_surface_material(2, material)
    material.albedo_color = Color(value)
