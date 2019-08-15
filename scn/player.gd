extends KinematicBody

var Laser = preload("res://scn/weapons/Laser.tscn")

export var speed = 1    # unit per seccond

var ammo = 1
var max_ammo = 1
var speed_bonus = 1 # miltiple

func _process(delta):
    var move = 0

    if Input.is_action_pressed("move_left"):
        move -= 1
    if Input.is_action_pressed("move_right"):
        move += 1

    if Input.is_action_just_pressed("shoot"):
        shoot()

    move_and_collide(Vector3(1,0,0) * move * speed * speed_bonus * delta)

func shoot():
    """Player can only shoot as many time as the ammo allows. Ammo is restored
    each time a player projectile exits the tree
    """
   
    if (ammo):
        ammo -= 1

        var projectile = Laser.instance()
        projectile.translation = $"gun".global_transform.origin
        projectile.connect("tree_exiting", self, "projectile_exiting_tree")
        find_parent("Game").call_deferred("add_child", projectile)


func projectile_exiting_tree():
    """Restores ammo to the player. Player shot projectiles are hooked to this
    function.
    
    By checking with max_ammo, ammo won't be restored by a second shot
    fired rigth before DoubleShot bonus gets disabled.
    """

    if ammo < max_ammo:
        ammo += 1


func hit():
    queue_free()


func _on_enemy_detector_body_entered(body):
    hit()


func _on_bonus_hit(bonus):
    """ Called by bonus objects when hit by projectile """

    if bonus == "RegenWalls":
        get_parent().regenWalls()
    if bonus == "DoubleShot":
        switchDoubleShot(true)
    if bonus == "Shield":
        print("Bonus was hit: ", bonus)
    if bonus == "Speed":
        switchSpeedBonus(true)


func switchDoubleShot(enable):
    if enable:
        max_ammo = 2
        ammo += 1
        $"Timer_BonusDoubleShot".start()
    else:
        max_ammo = 1
        ammo = min(ammo, 1)


func switchSpeedBonus(enable):
    if enable:
        speed_bonus = 1.50
        $"Timer_BonusSpeed".start()
    else:
        speed_bonus = 1

