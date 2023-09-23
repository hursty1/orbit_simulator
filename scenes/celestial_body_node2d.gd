extends Node2D



@export var radius : float 
@export var surfaceGravity : float
@export var initalVelocity: Vector2
@export var bodyName : String = "unnamed"

@export var mass : float
@export var velocity : Vector2

#@onready var rb : Node3D = $NODE3D
func _init(): #called when game starts reguardless of if this item is loaded
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("CelestialBody")
#	rb.mass = mass
	velocity = initalVelocity
	mass = surfaceGravity * radius * radius / Constants.gravitationalConstant




#func UpdateVelocity(allBodies: Array[CelestialBody], timeStep:float):
#
#	for otherBody in allBodies:
#		if otherBody != self:
#			var sqrDst : float = (otherBody.rb.position - rb.position).length_squared()
#			var forceDir : Vector3 = (otherBody.rb.position - rb.position).normalized()
#
#			var force : Vector3 = forceDir * Constants.gravitationalConstant * otherBody.mass * rb.mass / sqrDst #universal constant
#			var acceleration = force / rb.mass
#			velocity += acceleration * timeStep

func updateVelocitySingle(acceleration : Vector2, timeStep : float):
#	print(rb.mass)
	velocity += acceleration * timeStep
	

func updatePosition(timeStep:float):
#	var dir : Vector3 = (rb.global_transform.origin + velocity * timeStep).normalized()
#	self.translate(self.position + velocity * timeStep)
	self.global_transform.origin += velocity * timeStep
#	print("Name: " + name)
#	print("Position: " + str(self.position))
#	print("velocity: " + str(velocity))
#	print("timeStep: " + str(timeStep))
#	print("ts1: " + str(velocity * timeStep))
#	print("translate: " + str(self.position + velocity * timeStep))
#	rb.velocity
	
