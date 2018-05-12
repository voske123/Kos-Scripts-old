clearscreen.
// open terminal
core:doevent ("open terminal").



// wait til loaded
wait until ship:unpacked and ship:loaded.

//set ship pilotcontrol throttle to 0 to avoid troubles
set ship:control:pilotmainthrottle to 0.



// copy the mission and library over to the craft
if HOMECONNECTION:ISCONNECTED {
  copypath("0:/missions/"+shipname+".ks", "1:/mission.ks").
  print "boot completed.".
  run mission.ks.
} else {
  wait 10.
  reboot.
}

