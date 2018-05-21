//landing script for non_atmospheric body.

//calculate the height between me and the body
//check the vertical speed betweeen me and the surface.
//check the horizontal speed between me and the surface.
//calculate the time to impact.
//calculate the max burn time till i hit the ground.
//check if status of my ship = landed on the body.
lock throttle to throt.
lock steering to -velocity:surface + (up:vector * 1) + vxcl(up:vector, -velocity:surface) * 0.5.

set throt to 0.


function speed_altitude {
  set desired_throt_landing to 0.5.
  set acc to ship:availablethrust * (desired_throt_landing/ship:mass).
  set ship_height to 4.5.
  
  local speed is sqrt(max(0.00001, 2*acc*(alt:radar-ship_height))).
  
  return speed.
}

function throttle_speed {
  local my_speed is ship:velocity:surface:mag.
  local acceleration is ship:availablethrust/ship:mass.
  local gravity is body:mu/body:position:sqrmagnitude.
  
  set throt to ((gravity + (my_speed - speed_altitude()))/acceleration)*1.5.
  
}

when alt:radar < 800 then {
    legs on.
    print "landinglegs out.".
    panels on.
    print "panels on.".
  }

wait until vang(retrograde:vector, ship:facing:vector) < 2.
print "in position for retrograde burn.".

until ship:verticalspeed > - 2 and ship:status = "SUB_ORBITAL" {
  throttle_speed().
  
  print "apoapsis:         " + ship:apoapsis + "      "  at  (0,10).
  print "altitude:         " + alt:radar + "       " at (0,11).
  print "speed_altitude:   " + sqrt(max(0.00001, 2*acc*(alt:radar-ship_height))) + "       " at (0,12).
  print "my_speed:         " + ship:velocity:surface:mag + "        " at (0,13).
  print "shipstatus:       " + ship:status + "        "  at (0,14).
  print "throttle:         " + throttle + "       " at (0,15).

  wait 0.
}