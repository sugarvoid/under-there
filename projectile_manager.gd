class_name ProjectileManager
extends Node2D

const p_Projectile = preload("res://missile.tscn")


func add_bullet_to_screen(actor: Node2D) -> void:
	var projectile = p_Projectile.instance()
	projectile.damage_amount = actor.attack
	projectile.global_position = actor.muzzle.global_position
	projectile.global_rotation = actor.muzzle.global_rotation
	self.add_child(projectile)
