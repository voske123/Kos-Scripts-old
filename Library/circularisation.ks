// circularisation script
clearscreen.


function circularisation {
  if orbit:hasnextpatch {
    if ship:apoapsis < 0 {
      set eta_apoapsis to 0.
      set eta_periapsis to eta:periapsis.
    } 
    else if ship:periapsis < 0 {
      set eta_periapsis to 0.
      set eta_apoapsis to eta:periapsis.
    }
  }
  else {
    set eta_apoapsis to eta:apoapsis.
    set eta_periapsis to eta:periapsis.
  }

  if eta_apoapsis > eta_periapsis {  
  
  local speed_at_apo is sqrt(ship:body:mu / (ship:body:radius + ship:orbit:apoapsis)).

  local time_of_apo is eta:apoapsis + time:seconds.

  local deltav_needed is speed_at_apo - velocityat(ship,time_of_apo):orbit:mag. 

  set maneuver_node to node(time_of_apo,0,0,deltav_needed).

  add maneuver_node.
  
  
  } else if eta_apoapsis < eta_periapsis {

  local speed_at_peri is sqrt(ship:body:mu / (ship:body:radius + ship:orbit:periapsis)).

  local time_of_peri is eta:periapsis + time:seconds.

  local deltav_needed is speed_at_peri - velocityat(ship,time_of_peri):orbit:mag. 

  set maneuver_node to node(time_of_peri,0,0,deltav_needed).

  add maneuver_node.
  }

  lock steering to nextnode:burnvector.

  if hasnode {
    lock throttle to 0.
    wait 1.
  }
}