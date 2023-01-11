class_name Player
extends KinematicBody2D

signal on_shoot_pressed

export var speed = 70
export var friction = 0.1
export var acceleration = 0.2
export var fire_rate = 0.5
var can_fire: bool = true

var attack: int = 5

var velocity = Vector2()

onready var timer_firerate: Timer = get_node("TmrFireRate")
onready var stream_lines: Sprite = get_node("Sprite2")

var facing_dir: Vector2

onready var muzzle = get_node("Muzzle")

const ROTATE_DEG: Dictionary = {
	"up": -90.0,
	"down": 90.0,
	"left": 180.0,
	"right": 0.0,
}

func get_class() -> String:
	return "player"

func _ready() -> void:
	#self.animation_player.play("idle")
	
	self.timer_firerate.connect("timeout", self, "_reset_firerate_timer")

func get_movement_input():
	var input = Vector2()
	if Input.is_action_pressed('move_right'):
		
		input.x += 1
	elif Input.is_action_pressed('move_left'):
		input.x -= 1
	
	if Input.is_action_pressed('move_down'):

		input.y += 1
	
	elif Input.is_action_pressed('move_up'):

		input.y -= 1
		
	else:
		pass
		#$AnimatedSprite.play("default")
	self.facing_dir = input
	# print(facing_dir)
	return input

func get_shooting_dir():
	return Vector2(0,-1)
	
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		emit_signal("on_shoot_pressed", self)

#func _get_shooting_input() -> void:
#	if Input.is_action_pressed('shoot_right'):
#		_rotate_shooting_dir(ROTATE_DEG.right)
#		_shoot_bubble()
#	elif Input.is_action_pressed('shoot_left'):
#		_rotate_shooting_dir(ROTATE_DEG.left)
#		_shoot_bubble()
#	elif Input.is_action_pressed('shoot_down'):
#		_rotate_shooting_dir(ROTATE_DEG.down)
#		_shoot_bubble()
#	elif Input.is_action_pressed('shoot_up'):
#		_rotate_shooting_dir(ROTATE_DEG.up)
#		_shoot_bubble()

func _process(delta):
	### _get_shooting_input()
	var direction = get_movement_input()
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	velocity = self.move_and_slide(velocity)
	
	if self.velocity.x < 0:
		self.scale.x = scale.y * -1 
	elif velocity.x > 0:
		self.scale.x = scale.y * 1
	
	stream_lines.visible = facing_dir != Vector2(0,0)
	_update_stream_lines(self.facing_dir)

func _update_stream_lines(movement: Vector2) -> void:
	match self.facing_dir:
		Vector2(0, 0):
			print("not moving")
			#self.stream_lines.visible = false
			
		Vector2(0, -1):
			print("moving up")
			self.stream_lines.rotation_degrees = 90
		Vector2(0, 1):
			print("moving down")
			self.stream_lines.rotation_degrees = -90
		Vector2(1, 0):
			print("moving right")
			self.stream_lines.rotation_degrees = 180
		Vector2(-1, 0):
			print("moving left")
			self.stream_lines.rotation_degrees = -180
		
		
		Vector2(1, 1):
			print("moving down-right")
			self.stream_lines.rotation_degrees = -135
		Vector2(-1, -1):
			print("moving up-left")
			self.stream_lines.rotation_degrees = 135
		Vector2(1, -1):
			print("moving up-right")
			self.stream_lines.rotation_degrees = 135
		Vector2(-1, 1):
			print("moving down-left")
			self.stream_lines.rotation_degrees = -135


		
			

func _rotate_shooting_dir(rot_deg: float) -> void:
	self.pivit_point.set_rotation(rot_deg)


func _shoot_bubble() -> void:
	if self.can_fire:
		self.can_fire = false
		print('shoot bubble')
		emit_signal("on_shoot_pressed", self.muzzle)
		timer_firerate.start(self.fire_rate)

func get_facing_dir_string() -> String:
	match  self.facing_dir:
		Vector2(0,1):
			return "Down"
		Vector2(0,-1):
			return "Up"
		Vector2(-1,0):
			return "Left"
		Vector2(1,0):
			return "Right"
		_:
			return ""

func _reset_firerate_timer() -> void:
	self.can_fire = true
