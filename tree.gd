extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var hit_box: Area2D = get_node("HitBox")

func get_class() -> String:
	return "tree"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hit_box.connect("area_entered", self, "_on_area_entering_hitbox")
	pass # Replace with function body.

func _on_area_entering_hitbox(node: Node2D) -> void:
	node.queue_free()
	self._shake()

func _shake() -> void:
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("shake")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
