extends Node2D


func _ready() -> void:
	$Camera2D.player = get_node("Player")
	$Camera2D.set_up_camera()
	$Player.connect("on_shoot_pressed", $ProjectileManager, "add_bullet_to_screen")
	
	$Camera2D.connect("moving_position", self, "_prevent_player_movement")
	$Camera2D.connect("done_moving", self, "_allow_player_movent")

func _prevent_player_movement() -> void:
	$Player.can_move = false

func _allow_player_movent() -> void:
	$Player.can_move = true
