extends Spatial

var Game = preload("res://scn/Game.tscn")

var playing = false


func _ready():
    _on_game_over()


func _process(delta):
    if has_node("Game"):
        if Input.is_action_just_pressed("restart_game"):
            $"Game".free()
            var new_game = Game.instance()
            new_game.name = "Game"
            new_game.connect("game_over", self, "_on_game_over")
            call_deferred("add_child", new_game)

    if Input.is_action_just_pressed("close_game"):
        get_tree().quit()
    if Input.is_action_just_pressed("ui_accept"):
        if (not $"Game"):
            _on_Play_pressed()  


func _on_Play_pressed():
    var new_game = Game.instance()
    new_game.name = "Game"
    new_game.connect("game_over", self, "_on_game_over")
    call_deferred("add_child", new_game)
    $"Menu".hide()


func _on_game_over():
    $"Game".queue_free()
    $"Menu".show()


func quit():
    get_tree().quit()
