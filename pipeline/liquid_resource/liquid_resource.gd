extends Sprite

class_name LiquidResource

var liquid_scene: PackedScene = preload("res://pipeline/liquid/Liquid.tscn")
var pipe: Pipe
var board_coord: Tuple = Tuple.new(0, 0)
