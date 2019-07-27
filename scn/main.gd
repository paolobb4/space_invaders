extends Spatial

var Game = preload("res://scn/Game.tscn")


func _process(delta):
    if Input.is_action_just_pressed("restart_game"):
        $"Game".free()
        var new_game = Game.instance()
        new_game.name = "Game"
        add_child(new_game)
    if Input.is_action_just_pressed("close_game"):
        get_tree().quit()
