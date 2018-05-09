// circularisation script
clearscreen.

function circularisation {
  local speed_at_apo is sqrt(ship:body:mu / (ship:body:radius + ship:orbit:apoapsis)).

  local time_of_apo is eta:apoapsis + time:seconds.

  local deltav_needed is speed_at_apo - velocityat(ship,time_of_apo):orbit:mag. 

  set maneuver_node to node(time_of_apo,0,0,deltav_needed).

  add maneuver_node.
  
  lock steering to nextnode:burnvector.
  
  if hasnode {
    lock throttle to 0.
    wait 1.
  }
}