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

function mun_transfer {
  set kuniverse:timewarp:warp to 4.
  
  wait until vang(ship:body:position, mun:position) > 85 and vang(ship:body:position, body:position) < 95.
  kuniverse:timewarp:cancelwarp.
  
  wait until kuniverse:timewarp:issettled.

  lock steering to prograde.
  lock throttle to 1.
  wait until orbit:hasnextpatch. 
  lock throttle to 0.

  print "on the way to the mun!".
}

if ship:altitude < 500 and ship:groundspeed < 1  {
    clearscreen.
    set ship:control:pilotmainthrottle to 0.
    launch().
    circularisation().
    node_exec().
    clearscreen.
    print "In orbit around Kerbin.".
}

if ship:altitude > 70000 and ship:orbit:eccentricity < 0.1 {
  mun_transfer().
}
  wait 1.
  
  kuniverse:timewarp:warpto(time:seconds + orbit:nextpatcheta).
  wait until kuniverse:timewarp:issettled.
  wait until ship:body = mun.

  circularisation().
  node_exec().
  clearscreen.

  
print "In orbit around the mun.".







