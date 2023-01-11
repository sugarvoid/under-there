extends Camera2D

signal moving_position
signal done_moving

const PAN_SPEDD: float = 0.75

const SCREEN_SIZE: Vector2 = Vector2( 128, 128)
var cur_screen = Vector2(0,0)

var player: Player

func set_up_camera() -> void:
	print('set up')
	set_as_toplevel(true)
	self.global_position = self.player.global_position
	_update_screen(cur_screen)
	
func _physics_process(delta: float) -> void:
	var player_current_screeen = (self.player.global_position / SCREEN_SIZE).floor()
	if !player_current_screeen.is_equal_approx(cur_screen):
		_update_screen(player_current_screeen)
	
func _update_screen(new_screen: Vector2) -> void:
	print('updating screen')
	self.cur_screen = new_screen
	var new_pos = cur_screen * SCREEN_SIZE + SCREEN_SIZE * 0.5
	print('starting tween')
	$Tween.interpolate_property(self, "global_position", self.global_position, new_pos, PAN_SPEDD, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	#### self.global_position = cur_screen * SCREEN_SIZE + SCREEN_SIZE * 0.5
	print(self.global_position)
