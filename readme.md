# Orbit simulator


Implmentation of N-Body formula in godot

both 2d and 3d 


eg: 
var sqrDst : float = (otherBody.rb.position - rb.position).length_squared()
var forceDir : Vector3 = (otherBody.rb.position - rb.position).normalized()

var force : Vector3 = forceDir * Constants.gravitationalConstant * otherBody.mass * rb.mass / sqrDst #universal constant
var acceleration = force / rb.mass
velocity += acceleration * timeStep



a = f / m