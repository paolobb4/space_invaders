extends KinematicBody

var Laser = preload("res://scn/weapons/Laser.tscn")

export var speed = 1    # unit per seccond

var can_shoot = true

func _process(delta):
    var move = 0

    if Input.is_action_pressed("move_left"):
        move -= 1
    if Input.is_action_pressed("move_right"):
        move += 1

    if Input.is_action_just_pressed("shoot"):
        if (can_shoot):
            can_shoot = false
            var projectile = Laser.instance()
            projectile.translation = $"gun".global_transform.origin
            projectile.connect("tree_exiting", self, "projectile_exiting_tree")
            find_parent("Game").call_deferred("add_child", projectile)

    move_and_collide(Vector3(1,0,0) * move * speed * delta)


func projectile_exiting_tree():
    can_shoot = true


func hit():
    queue_free()


func _on_enemy_detector_body_entered(body):
    hit()


func _on_bonus_hit(bonus):
    if bonus == "RegenWalls":
        print("Bonus was hit: ", bonus)
    if bonus == "DoubleShot":
        print("Bonus was hit: ", bonus)
    if bonus == "Shield":
        print("Bonus was hit: ", bonus)
    if bonus == "Speed":
        print("Bonus was hit: ", bonus)
