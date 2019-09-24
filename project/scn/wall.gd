extends Spatial

var bucket = []


func regenerate():
    for wall_chunk in bucket:
        call_deferred("add_child", wall_chunk)
        wall_chunk.get_node("AnimationPlayer").play("spawn")
    bucket = []

func disable_wall_chunk(c):
    call_deferred("remove_child", c)
    bucket.append(c)
