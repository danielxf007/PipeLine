extends Sprite

class_name Liquid

var TYPES: Dictionary = {"water": preload("res://art/water.png"),
 "toxic": preload("res://art/toxic.png")}
var liquid_name: String

func _init(name: String) -> void:
	self.texture = self.TYPES[name]
	self.liquid_name = name

func change_type(name: String) -> void:
	self.texture = self.TYPES[name]
	self.liquid_name = name
