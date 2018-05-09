//pre launch
wait 1.

//copy librarys
copypath("0:/library/launch", "1:/launch").
copypath("0:/library/circularisation", "1:/circularisation").
copypath("0:/library/node_exec", "1:/node_exec").

//run librarys
run circularisation.
run node_exec.
run launch.

if ship:orbit:eccentricity > 0.1 {
  if ship:altitude < 70000 {
    clearscreen.
    set ship:control:pilotmainthrottle to 0.
    launch().
    circularisation().
    node_exec().
    clearscreen.   

  } else if ship:altitude > 70000 and not(hasnode)  {
    circularisation().
    node_exec().
    clearscreen.

  } else if ship:altitude > 70000 and hasnode {
    node_exec.
    clearscreen.
  }
}

else if ship:altitude > 70000 and ship:orbit:eccentricity < 0.1 {
  
  set kuniverse:timewarp:warp to 4.

  if vang(ship:body:position, mun:body:vector) > 85 and vang(ship:body:position, mun:body:vector) < 95. {
    cancelwarp().
  }
  wait until kuniverse:issettled.

  lock steering to prograde.

  until orbit:hasnextpatch {
  lock throttle to 1.
  }

  lock throttle to 0.

  print "on the way to the mun!".
}



