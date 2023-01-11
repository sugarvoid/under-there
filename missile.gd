extends Node2D


onready var sprite: Sprite = get_node("Sprite")
onready var hit_box: Area2D = get_node("HitBox")

var projectile_ID: String
var speed: float = 150.0
var life: float
var damage_amount: int 

func get_class() -> String:
	return "Projectile"


func _physics_process(delta):
	global_position += Vector2(cos(rotation), sin(rotation)) * speed * delta

func _ready() -> void:
	self.hit_box.connect("body_entered", self, "made_contact")
	self.hit_box.connect("area_entered", self, "made_contact")

func _on_LifeTimer_timeout() -> void:
	self.queue_free()

func made_contact(thing: Node) -> void:
	if thing.get_class() != "player":
		print("Made contact with: ", thing.name)
		##thing.take_damage(self.damage_amount)
		self.queue_free()
